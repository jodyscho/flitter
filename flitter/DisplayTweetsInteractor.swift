//
//  DisplayTweetsInteractor.swift
//  flitter
//

import Foundation
import Swinject


protocol DisplayTweetsInteractorOutput: class {
    
}

class DisplayTweetsInteractor {
    weak var output: DisplayTweetsInteractorOutput?

}
