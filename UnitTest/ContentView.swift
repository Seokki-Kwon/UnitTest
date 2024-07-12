//
//  ContentView.swift
//  UnitTest
//
//  Created by 석기권 on 7/13/24.
//

import SwiftUI
import Combine

struct TestModel: Identifiable {
    let id = UUID().uuidString
    let name: String
}

class TestDataService {
    private let data = [TestModel(name: "1"),
                TestModel(name: "2"),
                TestModel(name: "3")]
    
    func fetchData() -> AnyPublisher<[TestModel], Never> {
        return Just(data)
            .delay(for: 2, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum TestError: Error {
    case rangeError
    
    var errorType: Int {
        switch self {
        case .rangeError:
            0
        }
    }
}

class TestViewModel: ObservableObject {
    @Published var models: [TestModel] = []
    
    let dataService: TestDataService

    var cancellable: AnyCancellable?
    
    init(_ dataService: TestDataService) {
        self.dataService = dataService
        
       cancellable = dataService.fetchData()
            .assign(to: \.models, on: self)
    }
    
    func addData(_ model: TestModel) {
        models.append(model)
    }
    
    func removeData(at index: Int) throws {
        if index >= models.count {
            throw TestError.rangeError
        }
        models.remove(at: index)
    }
    
    func removeAllData() {
        models.removeAll()
    }
}

struct ContentView: View {
    @StateObject var viewModel = TestViewModel(TestDataService())
    
    var body: some View {
        VStack {
            List(viewModel.models) {
                Text($0.name)
            }
            
            Button(action: {}, label: {
                Text("Add Model")
            })
            
            Button(action: {}, label: {
                Text("Delete Model")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
