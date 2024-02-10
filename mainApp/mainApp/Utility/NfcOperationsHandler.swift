//
//  NfcOperationsHandler.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import CoreNFC

class NfcOperationsHandler: NSObject, NFCNDEFReaderSessionDelegate{
    private let taskDG = DispatchGroup()
    private var readSession: NFCNDEFReaderSession?
    private var writeSession: NFCNDEFReaderSession?
    
    var operationDone: Bool = false
    var isWriteSuccess: Bool = false
    var actionText: String? = nil
    
    func startNFCReading() -> String? {
        
        readSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        readSession?.alertMessage = NSLocalizedString("NfcReadyAlert", comment: "")
        readSession?.begin()
        
        self.operationDone = false
        self.actionText = nil
        taskDG.enter()
        DispatchQueue.global().async {
            while true {
                if self.operationDone{
                    break
                }
                usleep(100000)
            }
            self.taskDG.leave()
        }
        taskDG.wait()
        
        return self.actionText
    }
    
    func startNFCWriting(rawString: String)  -> Bool {
        
        self.isWriteSuccess = false
        self.operationDone = false
        self.combineFormat(rawString: rawString)
        writeSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        writeSession?.alertMessage = NSLocalizedString("NfcReadyAlert", comment: "")
        writeSession?.begin()
        
        taskDG.enter()
        DispatchQueue.global().async {
            while true {
                if self.operationDone{
                    break
                }
                usleep(100000)
            }
            self.taskDG.leave()
        }
        taskDG.wait()
        
        return self.isWriteSuccess
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                let payloadData = record.payload
                let payloadString = String(data: payloadData, encoding: .utf8)
                print("NFC Payload：\(payloadString ?? "Error")")
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        
        guard let tag = tags.first else {
            session.invalidate(errorMessage: NSLocalizedString("ErrorNoTags", comment: ""))
            return
        }
                    
        session.connect(to: tag) { (error: Error?) in
            if error != nil {
                session.invalidate(errorMessage: NSLocalizedString("ErrorConnectFailed", comment: ""))
                return
            }
            
            if tag.isAvailable {
                print("NDEF Available")
            } else {
                print("NDEF non-Available")
                session.invalidate(errorMessage: NSLocalizedString("ErrorNotNDEF", comment: ""))
                return
            }

            if session == self.readSession {
                print("Performing read operation...")
                
                tag.queryNDEFStatus { (status: NFCNDEFStatus, capacity, error) in
                    if let error = error {
                        print("Error read NDEF ststus: \(error.localizedDescription)")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorReadNDEFStatusFailed", comment: ""))
                        return
                    }
 
                    if  status == NFCNDEFStatus.notSupported {
                        print("Tag is not NDEF formatted; NDEF read and write are disallowed.")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorStatusNotSupport", comment: ""))
                        return
                    }
                    
                    tag.readNDEF { (ndefMessage: NFCNDEFMessage?, error: Error?) in
                        if let error = error {
                            print("Error reading NDEF message: \(error.localizedDescription)")
                            session.invalidate(errorMessage: NSLocalizedString("ErrorReadNDEFMessageFailed", comment: ""))
                            return
                        }
                        
                        if let ndefMessage = ndefMessage {
                            print("Successfully read NDEF message:")
                            var recordCount = 0
                            for record in ndefMessage.records {
                                recordCount += 1
                                print("Payload count:", recordCount)
                                //print("Payload data:", record)
                                
                                // Ignore the Type.
                                let payload: Data = Data(record.payload.dropFirst())
                                
                                if let payloadString = String(data: payload, encoding: .utf8) {
                                    print("Payload string:", payloadString)
                                    
                                    if recordCount == 1 && !self.VerifyWeblink(rawString: payloadString) {
                                        print("Payload could not valid.")
                                        session.invalidate(errorMessage: NSLocalizedString("ErrorPayloadParsingFailed", comment: ""))
                                        return
                                    }
                                    
                                    if recordCount == 2 && !self.VerifyFormat(rawString: payloadString) {
                                        print("Payload could not valid.")
                                        session.invalidate(errorMessage: NSLocalizedString("ErrorPayloadParsingFailed", comment: ""))
                                        return
                                    }
                                    session.alertMessage = NSLocalizedString("NfcReadSuccess", comment: "")
                                } else {
                                    print("Payload could not be decoded as UTF-8 string")
                                    session.invalidate(errorMessage: NSLocalizedString("ErrorPayloadDecodingFailed", comment: ""))
                                    return
                                }
                            }
                        } else {
                            print("No NDEF message found on the NFC card.")
                            session.invalidate(errorMessage: NSLocalizedString("ErrorNoPayloadDetect", comment: ""))
                            return
                        }
                        session.invalidate()
                    }
                }
            } else if session == self.writeSession {
                print("Performing write operation...")
                
                tag.queryNDEFStatus { (status: NFCNDEFStatus, capacity, error) in
                    if let error = error {
                        print("Error read NDEF ststus: \(error.localizedDescription)")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorReadNDEFStatusFailed", comment: ""))
                        return
                    }
 
                    if  status == NFCNDEFStatus.notSupported {
                        print("Tag is not NDEF formatted; NDEF read and write are disallowed.")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorStatusNotSupport", comment: ""))
                        return
                    } else if status == NFCNDEFStatus.readOnly {
                        print("Tag is NDEF read-only; NDEF writing is disallowed.")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorStatusReadOnly", comment: ""))
                        return
                    }
                    
                    // NTAG215 up support.
                    if capacity < 500 {
                        print("Tag size is less than 500 bytes.")
                        session.invalidate(errorMessage: NSLocalizedString("ErrorSizeInsufficient", comment: ""))
                        return
                    }
                    
                    // Note: wellKnownTypeTextPayload is coding by UTF16, is will need double size and mismatch with others...
                    let urlRecord = NFCNDEFPayload.wellKnownTypeURIPayload(string: AppLink.appStore)!
                    let textRecord = NFCNDEFPayload.wellKnownTypeURIPayload(string: self.actionText!)!
                    let ndefMessage = NFCNDEFMessage.init(records: [urlRecord, textRecord])
                    tag.writeNDEF(ndefMessage) { (writeError: Error?) in
                        if let writeError = writeError {
                            print("Error writing NDEF message: \(writeError.localizedDescription)")
                            session.invalidate(errorMessage: NSLocalizedString("ErrorWriteFailed", comment: ""))
                            return
                        } else {
                            
                            print("Successfully wrote NDEF message to the NFC card.")
                            self.isWriteSuccess = true
                            session.alertMessage = NSLocalizedString("NfcWriteSuccess", comment: "")
                            session.invalidate()
//                            // Enable to lock card.
//                            tag.writeLock { (lockError: Error?) in
//                                if let writeError = writeError {
//                                    print("Error lock NFC tag: \(writeError.localizedDescription)")
//                                    session.invalidate(errorMessage: NSLocalizedString("ErrorLockFailed", comment: ""))
//                                    return
//                                } else {
//                                    print("Successfully wrote NDEF message to the NFC card.")
//                                    self.isWriteSuccess = true
//                                    session.alertMessage = NSLocalizedString("NfcWriteSuccess", comment: "")
//                                    session.invalidate()
//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let nfcError = error as? NFCReaderError, nfcError.code == .readerSessionInvalidationErrorUserCanceled {
            print("NFC Done")
        } else {
            print("NFC Error：\(error.localizedDescription)")
        }
        self.operationDone.toggle()
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("readerSessionDidBecomeActive")
    }
    
    func VerifyWeblink(rawString: String) -> Bool{
        return AppLink.appStore.contains(rawString)
    }
    
    func VerifyFormat(rawString: String) -> Bool{
        if rawString.hasPrefix("MenmonicHero") {
            let parsingString = rawString.split(separator: ":")
            self.actionText = String(parsingString[1])
            return true
        } else {
            return false
        }
    }
    
    func combineFormat(rawString: String) {
        let prefix: String = "MenmonicHero"
        self.actionText = prefix + ":" + rawString
    }
}
