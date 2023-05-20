//
//  ToldModeHandler.swift
//  ToldSDK
//
//  Created by Darius MARTIN on 26/04/2023.
//

enum MODE {
    case PRODUCTION, PREVIEW, DEBUG
}

public class ToldModeHandler {
    
    public var mode = MODE.PRODUCTION {
        didSet {
            print("Coucou le mode vient de changer")
        }
    }
    
}
