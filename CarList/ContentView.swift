//
//  ContentView.swift
//  CarList
//
//  Created by Jude Song on 4/16/24.
//

import SwiftUI

protocol CarDescriptionProtocol {
    var brand: String { get }
    var modelName: String { get }
    var year: Int { get }
    
    func getDetails() -> String
}

class Car: Identifiable, CarDescriptionProtocol {
    let id = UUID()
    var brand: String
    var modelName: String
    var year: Int
    var doorCount: Int
    var weight: Double
    var height: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double) {
        self.brand = brand
        self.modelName = modelName
        self.year = year
        self.doorCount = doorCount
        self.weight = weight
        self.height = height
        
    }
        func getDetails() -> String {
            return "Brand: \(brand)\nModel: \(modelName)\nYear: \(year)"
    }
}


class ElectricCar: Car {
    var electricEfficiency: Double
    var fullChargeHours: Double
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, electricEfficiency: Double, fullChargeHours: Double, autoLevel: Int) {
        self.electricEfficiency = electricEfficiency
        self.fullChargeHours = fullChargeHours
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
        
    }
    
    override func getDetails() -> String {
        return super.getDetails() + "\nElectric Efficiency: \(electricEfficiency)\nChargeHour: \(fullChargeHours)"
    }
    
}

class OilCar: Car {
    var isAutomatic: Bool
    var isGasoline: Bool
    var fuelEfficiency: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, isAutomatic: Bool, isGasoline: Bool, fuelEfficiency: Double) {
        self.isAutomatic = isAutomatic
        self.isGasoline = isGasoline
        self.fuelEfficiency = fuelEfficiency
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}

class HybridCar: Car {
    var autoLevel: Int
    var isGasoline: Bool
    var fuelEfficiency: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double, autoLevel: Int, isGasoline: Bool, fuelEfficiency: Double) {
        self.autoLevel = autoLevel
        self.isGasoline = isGasoline
        self.fuelEfficiency = fuelEfficiency
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}

let teslaModelX: ElectricCar = ElectricCar(brand: "Tesla", modelName: "Model X", year: 2015, doorCount: 4, weight: 100, height: 40, electricEfficiency: 439, fullChargeHours: 5, autoLevel: 2)
let teslaModelY: ElectricCar = ElectricCar(brand: "Tesla", modelName: "Model Y", year: 2015, doorCount: 4, weight: 100, height: 40, electricEfficiency: 511, fullChargeHours: 7, autoLevel: 3)
let kiaK9: OilCar = OilCar(brand: "KIA", modelName: "K9", year: 2022, doorCount: 4, weight: 70, height: 35, isAutomatic: true, isGasoline: true, fuelEfficiency: 9.0)
let kiaK8: OilCar = OilCar(brand: "KIA", modelName: "K8", year: 2023, doorCount: 4, weight: 70, height: 35, isAutomatic: true, isGasoline: true, fuelEfficiency: 18.0)
let kiaK5: OilCar = OilCar(brand: "KIA", modelName: "K5", year: 2023, doorCount: 4, weight: 70, height: 35, isAutomatic: true, isGasoline: true, fuelEfficiency: 20.0)
let prius: HybridCar = HybridCar(brand: "Toyota", modelName: "Prius", year: 2023, doorCount: 4, weight: 60, height: 40, autoLevel: 0, isGasoline: true, fuelEfficiency: 65)
let grandeurHybrid: HybridCar = HybridCar(brand: "Hyundai", modelName: "그렌저 하이브리드", year: 2023, doorCount: 4, weight: 70, height: 35, autoLevel: 1, isGasoline: true, fuelEfficiency: 16.7)

let cars: [Car] = [teslaModelX, teslaModelY, kiaK5, kiaK8, kiaK9, prius, grandeurHybrid]

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Electric Cars")) {
                    ForEach(cars.filter { $0 is ElectricCar}) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            Text(car.modelName)
                        }
                    }
                }
                Section(header: Text("Oil Cars")) {
                    ForEach(cars.filter { $0 is OilCar}) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            Text(car.modelName)
                        }
                    }
                }
                Section(header: Text("Hybrid Cars")) {
                    ForEach(cars.filter { $0 is HybridCar}) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            Text(car.modelName)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Car List")
        }
    }
}

struct CarDetailView: View {
    let car: Car
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text(car.modelName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(car.getDetails())
                .font(.body)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
