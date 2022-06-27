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
        let fakeMainSceneService = FakeMainSceneService()
        let fakeViewController = FakeMainSceneViewController()
        let sut = MainSceneViewModel(service: fakeMainSceneService)
        sut.viewController = fakeViewController
        
        let expectation = XCTestExpectation()
        fakeViewController.expectation = expectation
        
        sut.getPokemonList()
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(fakeViewController.shouldDisplayPokemons)
    }
    
    func test_getPokemonList_withFailure() {
        let fakeMainSceneService = FakeMainSceneService()
        fakeMainSceneService.isSuccess = false
        let fakeViewController = FakeMainSceneViewController()
        let sut = MainSceneViewModel(service: fakeMainSceneService)
        sut.viewController = fakeViewController
        
        let expectation = XCTestExpectation()
        fakeViewController.expectation = expectation
        
        sut.getPokemonList()
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(fakeViewController.shouldDisplayError)
    }
}

class FakeMainSceneService: ServiceContract {
    var isSuccess = true
    
    func fetch<T: Decodable>(endpoint: EndpointContract, completion: @escaping (Result<T, Error>) -> Void) {
        if isSuccess {
            let response = PokemonResponse(count: nil, next: nil, previous: nil, results: nil)
            completion(.success(response as! T))
        } else {
            completion(.failure(RequesterError.unknownError))
        }
        
    }
    
    func fetch<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        if isSuccess {
            let response = PokemonResponse(count: nil, next: nil, previous: nil, results: nil)
            completion(.success(response as! T))
        } else {
            completion(.failure(RequesterError.unknownError))
        }
    }
}

class FakeMainSceneViewController: MainSceneViewControllerDisplay {
    var shouldDisplayPokemons = false
    var shouldDisplayError = false
    var expectation: XCTestExpectation?
    
    func displayPokemons(pokemons: [Pokemon]) {
        shouldDisplayPokemons = true
        expectation?.fulfill()
    }
    
    func displayError(_ errorDescription: String) {
        shouldDisplayError = true
        expectation?.fulfill()
    }
    
    func updateLabel(text: String) { }
    
    func startLoaderAnimation() { }
    
    func stopLoaderAnimation() { }
}
