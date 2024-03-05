//
//  UserInfoViewModel.swift
//  mainApp
//
//  Created by Andy on 1/12/24.
//

import Foundation
import Combine

class UserInfoViewModel: ObservableObject {
    // Input
    @Published var cardname = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    // Output
    //@Published var isCardnameLengthValid = false
    @Published var isCardnamePass = false
    @Published var isPasswordPass = false
    @Published var isPasswordConfirmValid = false
    @Published var isAllPass = false    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $cardname
            .receive(on: RunLoop.main)
            .map { cardname in
                let nameRegex = #"^[ -~]{4,16}$"#
                return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: cardname)
            }
            .assign(to: \.isCardnamePass, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                //let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[ -~]{4,16}$"
                let passwordRegex = #"^[ -~]{8,16}$"#
                return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
            }
            .assign(to: \.isPasswordPass, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest3(
            $isCardnamePass,
            $isPasswordPass,
            $isPasswordConfirmValid
        )
        .receive(on: RunLoop.main)
        .map { isCardnamePass, isPasswordPass, isPasswordConfirmValid in
            return isCardnamePass && isPasswordPass && isPasswordConfirmValid
        }
        .assign(to: \.isAllPass, on: self)
        .store(in: &cancellableSet)
    }
    
    func clearData() {
        cardname = ""
        password = ""
        passwordConfirm = ""
    }
}

