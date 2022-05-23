//
//  LalalalaTests.swift
//  LalalalaTests
//
//  Created by Sai Leung on 5/19/22.
//

import XCTest
@testable import Lalalala

class DeliveryTests: XCTestCase {
    
    var mockDelivery: Delivery?
    var mockRoute: Route?
    var mockSender: Sender?

    override func setUpWithError() throws {
        mockSender = Sender(phone: "+1 (888) 888-8888", name: "Tester", email: "test@test.com")
        mockRoute = Route(start: "Test Street", end: "Test Court")
    }

    override func tearDownWithError() throws {
        
    }

    func testDelivery() throws {
        guard let mockRoute = mockRoute, let mockSender = mockSender else {
            throw TestError.unwrappingWithNilValue
        }
        mockDelivery = Delivery(id: "testId", remarks: "testRemarks", pickupTime: "testPickupTime", goodsPicture: "test.insert", deliveryFee: "deliveryFee", surcharge: "$136.46", route: mockRoute, sender: mockSender)
        XCTAssertEqual(mockDelivery?.id, "testId")
        XCTAssertEqual(mockDelivery?.remarks, "testRemarks")
        XCTAssertEqual(mockDelivery?.pickupTime, "testPickupTime")
        XCTAssertEqual(mockDelivery?.goodsPicture, "test.insert")
        XCTAssertEqual(mockDelivery?.deliveryFee, "deliveryFee")
        XCTAssertEqual(mockDelivery?.surcharge, "$136.46")
    }
    
    func testRoute() throws {
        guard let mockRoute = mockRoute, let mockSender = mockSender else {
            throw TestError.unwrappingWithNilValue
        }
        mockDelivery = Delivery(id: "testId", remarks: "testRemarks", pickupTime: "testPickupTime", goodsPicture: "test.insert", deliveryFee: "deliveryFee", surcharge: "$136.46", route: mockRoute, sender: mockSender)
        XCTAssertEqual(mockDelivery?.route.start, "Test Street")
        XCTAssertEqual(mockDelivery?.route.end, "Test Court")
    }
    
    func testSender() throws {
        guard let mockRoute = mockRoute, let mockSender = mockSender else {
            throw TestError.unwrappingWithNilValue
        }
        mockDelivery = Delivery(id: "testId", remarks: "testRemarks", pickupTime: "testPickupTime", goodsPicture: "test.insert", deliveryFee: "deliveryFee", surcharge: "$136.46", route: mockRoute, sender: mockSender)
        XCTAssertEqual(mockDelivery?.sender.phone, "+1 (888) 888-8888")
        XCTAssertEqual(mockDelivery?.sender.name, "Tester")
        XCTAssertEqual(mockDelivery?.sender.email, "test@test.com")
    }
}

enum TestError: Error {
    case unwrappingWithNilValue
}

