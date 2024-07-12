//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by 석기권 on 7/13/24.
//

/*:
 ## Test Structure
 - TestMethod: 코드의 일부를 검증하는 메서드 통과 또는 실패 결과를 생성
 - TestClass: TestMethod의 집합 일반적으로 테스트할 로직을 그룹화(ex: 인증)
 - TextBundle: 테스트 클래스 그룹을 포함하며 UnitTest 또는 UITest 유형중 하나이다
 - TestPlan: TestBundle의 그룹이며 테스트 계획에서 테스트를 실행할 때 고려해야 할 구성 목록을 설정?
 
XCTest
Apple에서 제공하는 Test Framework
 
XCTestCase
단위 테스트를 작성하고 실행하는데 필요한 모든 작업을 제공하는 클래스

 ## Test Pattern
 Arrange / Act / Assert
 Arrange: 테스트에 사용되는 객체 또는 데이터를 생성
 Act: 메서드나 함수를 실행
 Assert: 테스트 결과를 비교
 */
import XCTest
@testable import UnitTest

final class UnitTestTests: XCTestCase {
    private var viewModel: TestViewModel!
    
    // 테스트 하기전에 실행되는 메서드
    override func setUpWithError() throws {
        viewModel = TestViewModel(TestDataService())
    }

    // 테스트가 종료되고 정리 메서드
    override func tearDownWithError() throws {
        viewModel.removeAllData()
        viewModel = nil
    }
    
    // 모델 추가 테스트
    func testAddNewModel() throws {
        // Arrange
        let newModel = TestModel(name: "1")
        
        // Act
        viewModel.addData(newModel)
        
        // Assert
        XCTAssertEqual(viewModel.models.count, 1) // 2개의 비교결과 검증
    }
    
    func testRemoveModel() throws {
        let newModel = TestModel(name: "1")
        let newModel2 = TestModel(name: "2")
        
        viewModel.addData(newModel)
        viewModel.addData(newModel2)
        
        // removeData 메서드가 thorw 하는경우
        // Error를 throw하지 않는 경우도 테스트 실패
        XCTAssertThrowsError(try viewModel.removeData(at: 1)) { error in
           XCTFail("Error")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
