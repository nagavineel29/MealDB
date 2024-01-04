//
//  MealDBTests.swift
//  MealDBTests
//
//  Created by naga vineel golla on 1/3/24.
//

import XCTest
import Combine
@testable import MealDB

final class MealDBTests: XCTestCase {
    
    var mockService = MockMealSearchService()
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMealViewModelFail() {
        // Given
        var mockService = MockMealSearchService()
        mockService.isSuccess = false
        
        // When
        var sut = MealViewModel(service: mockService, mealId: "1234")
        
        // Then
        XCTAssertNil(sut.meal)
    }
    
    func testMealViewModelSuccess() {
        // Given
        var mockService = MockMealSearchService()
        mockService.isSuccess = true
        
        // When
        let expectation = XCTestExpectation(description: "fetchMeal")
        
        var sut = MealViewModel(service: mockService, mealId: "1234")
        sut.$meal
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getMeals()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(sut.meal)
    }
    
    func testMealViewModelStatusLoaded() {
        // Given
        var mockService = MockMealSearchService()
        mockService.isSuccess = true
        
        // When
        let expectation = XCTestExpectation(description: "fetchMeal")
        
        var sut = MealViewModel(service: mockService, mealId: "1234")
        sut.$status
            .dropFirst(2)
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getMeals()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.status, status.Loaded)
    }
    
    func testMealsListViewModelSuccess() {
        // Given
        mockService.isSuccess = true
        
        // When
        let expectation = XCTestExpectation(description: "fetchMeal")
    
        var sut = MealsListViewModel(service: mockService)
        sut.$meals
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getMeals()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(sut.meals)
    }
    
    func testMealsListViewModelFail() {
        // Given
        mockService.isSuccess = false
        
        // When
        var sut = MealsListViewModel(service: mockService)
        sut.getMeals()
        
        // Then
        XCTAssertEqual(sut.meals, [])
    }
    
    func testMealsListViewModel_filterAndSort() {
        // Given
        mockService.isSuccess = true
        let meals = [Meal(mealId: "52893", mealName: "Apple & Blackberry Crumble", poster: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"), Meal(mealId: "52768", mealName: "Apple Frangipan Tart", poster: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"), Meal(mealId: "52917", mealName: "White chocolate creme brulee", poster: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg")]
        
        
        // When
        let expectation = XCTestExpectation(description: "fetchMeal")
        
        var sut = MealsListViewModel(service: mockService)
        sut.$meals
            .dropFirst()
            .sink(receiveValue: { value in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        sut.getMeals()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.meals.last?.mealName, meals.last?.mealName)
    }
    
    func testMealsListEndPoint() {
        // Given
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        // When
        let EndPoint = EndPoint.searchCategory(category: "Dessert")
        
        // Then
        XCTAssertEqual(EndPoint.url, url)
    }
    
    func testMealEndPoint() {
        // Given
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")
        
        // When
        let EndPoint = EndPoint.mealDetails(mealId: "53049")
        
        // Then
        XCTAssertEqual(EndPoint.url, url)
    }

}
