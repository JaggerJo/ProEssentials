//
//  EventAggregator.swift
//  ProEssentials.Lib
//
//  Created by Josua Jaeger on 02.04.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Foundation

public class EventAggregator {
    public static let shared: EventAggregator = EventAggregator()
    
    public var events: [Event<Any>] = [Event<Any>]()
    
    private func findOrRegisterEvent<T>(eventType: Event<T>.Type) -> Event<T> {
        var event: Event<T>? = events
            .filter { Mirror(reflecting: $0).subjectType == eventType }
            .first as! Event<T>?
        
        if let knownEvent = event {
            return knownEvent
        }
        else {
            event = eventType.init(dataType: T.self)
            events.append(event as! Event<Any>)
            return event!
        }
    }
    
}

public extension EventAggregator {
    subscript<T>(eventType: Event<T>.Type) -> Event<T> {
        get {
            return self.findOrRegisterEvent(eventType: eventType)
        }
    }
}

public class Event<T> {
    private var subscriptions: [Subscription<T>] = [Subscription<T>]()
    
    public func subscribe(withHandler handler: @escaping (T) -> Void) -> Subscription<T> {
        let subscription = Subscription(withHandler: handler)
        self.subscriptions.append(subscription)
        
        return subscription
    }
    
    public func publish(withData data: T) {
        for subscription in subscriptions {
            subscription.delegate(data)
        }
    }
    
    required public init<T>(dataType: T.Type) {
        
    }
}

public class Subscription<T> {
    public var delegate: (T) -> Void
    
    public init(withHandler handler: @escaping (T) -> Void) {
        self.delegate = handler
    }
}
