//
//  MainSceneViewModelTests.swift
//  PokeAPIChallengeTests
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import XCTest
@testable import PokeAPIChallenge

class MainSceneViewModelTests: XCTestCase {

    func test_getPokemonList_withSuccess() {
        let fakeParser = FakeParser()
        let fakeViewController = FakeMainSceneViewController()
        let sut = MainSceneViewModel(parser: fakeParser)
        sut.viewController = fakeViewController
        
        let expectation = XCTestExpectation()
        fakeViewController.expectation = expectation
        
        sut.getPokemonList()
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(fakeViewController.shouldDisplayPokemons)
    }
    
    func test_getPokemonList_withFailure() {
        let fakeParser = FakeParser()
        fakeParser.isSuccess = false
        let fakeCoordinator = FakeMainSceneCoordinator()
        let sut = MainSceneViewModel(coordinator: fakeCoordinator, parser: fakeParser)
        
        let expectation = XCTestExpectation()
        fakeCoordinator.expectation = expectation
        
        sut.getPokemonList()
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(fakeCoordinator.shouldPresentErrorAlert)
    }
    
    func test_showDetails() {
        let fakeCoordinator = FakeMainSceneCoordinator()
        let sut = MainSceneViewModel(coordinator: fakeCoordinator)
        
        sut.showDetails(pokemon: Pokemon(name: nil, url: nil))
        
        XCTAssert(fakeCoordinator.shouldShowDetails)
    }
}

class FakeParser: ParserContract {
    var isSuccess = true
    
    func parseData<T: Decodable>(from: EndpointContract, completion: @escaping (Result<T, Error>) -> Void) {
        if isSuccess {
            let response = PokemonResponse(count: nil, next: nil, previous: nil, results: nil)
            completion(.success(response as! T))
        } else {
            completion(.failure(RequesterError.unknownError))
        }
        
    }
    
    func parseData<T: Decodable>(from: String, completion: @escaping (Result<T, Error>) -> Void) {
        if isSuccess {
            let response = PokemonResponse(count: nil, next: nil, previous: nil, results: nil)
            completion(.success(response as! T))
        } else {
            completion(.failure(RequesterError.unknownError))
        }
    }
    
    func getRawData(from url: String, completion: @escaping (Result<Data, Error>) -> Void) { }
}

class FakeMainSceneViewController: MainSceneViewControllerDisplay {
    var shouldDisplayPokemons = false
    var expectation: XCTestExpectation?
    
    func displayPokemons(pokemons: [Pokemon]) {
        shouldDisplayPokemons = true
        expectation?.fulfill()
    }
    
    func updateLabel(text: String) { }
    
    func startLoaderAnimation() { }
    
    func stopLoaderAnimation() { }
}

class FakeMainSceneCoordinator: MainSceneCoordinating {
    var viewController: UIViewController?
    var expectation: XCTestExpectation?
    var shouldPresentErrorAlert = false
    var shouldShowDetails = false
    
    func perform(action: MainSceneAction) {
        switch action {
        case .showDetails:
            shouldShowDetails = true
        case .presentErrorAlert:
            expectation?.fulfill()
            shouldPresentErrorAlert = true
        }
    }
}
