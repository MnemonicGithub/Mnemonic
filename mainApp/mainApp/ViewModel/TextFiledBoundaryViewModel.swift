//
//  TextFiledBoundaryViewModel.swift
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
    @Published var isCardnameCapitalLetter = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $cardname
            .receive(on: RunLoop.main)
            .map { cardname in
                let nameRegex = #"^[ -~]{1,16}$"#
                return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: cardname)
            }
            .assign(to: \.isCardnameCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 4 && password.count <= 16
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[ -~]{1,16}$"
                return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
}

