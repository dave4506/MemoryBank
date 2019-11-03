//
//  CognitoAuthIdentityProvider.swift
//  diyhs
//
//  Created by Vohra, Ajay on 8/17/19.
//

import AWSCore
import AWSCognitoIdentityProvider

final class CognitoUserPoolIdentityProvider: NSObject, AWSIdentityProviderManager {
    var tokens: [String : String]?
    
    init(tokens: [String : String]?) {
        self.tokens = tokens
    }
    
    /**
     Each entry in logins represents a single login with an identity provider.
     The key is the domain of the login provider. For Cognito user pool, the key is: “cognito-idp.<region>.amazonaws.com/<USERPOOLID>”
     The value is the OAuth/JWT token
     */
    func logins() -> AWSTask<NSDictionary> {
        let logins: NSDictionary = NSDictionary(dictionary: tokens ?? [:])
        return AWSTask(result: logins)
    }
}
