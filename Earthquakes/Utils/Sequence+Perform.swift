//
//  Sequence+Perform.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 08.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import Foundation

public extension Sequence {
    /// Perform a side effect for each element in `self`.
    @discardableResult
    func forEachPerform(_ body: (Element) throws -> Void) rethrows -> Self {
        try forEach(body)
        return self
    }
}

public extension Sequence {
    /// Perform a side effect.
    @discardableResult
    func perform(_ body: (Self) throws -> Void) rethrows -> Self {
        try body(self)
        return self
    }
}

public struct LazyForEachIterator<Base: IteratorProtocol>: IteratorProtocol {
    public mutating func next() -> Base.Element? {
        guard let nextElement = base.next() else {
            return nil
        }
        perform(nextElement)
        return nextElement
    }
    var base: Base
    let perform: (Base.Element) -> Void
}

public struct LazyForEachSequence<Base: Sequence>: LazySequenceProtocol {
    public func makeIterator() -> LazyForEachIterator<Base.Iterator> {
        return LazyForEachIterator(
            base: base.makeIterator(),
            perform: perform)
    }
    let base: Base
    let perform: (Base.Element) -> Void
}

public extension LazySequenceProtocol {
    func forEachPerform(_ body: @escaping (Element) -> Void) -> LazyForEachSequence<Self> {
        return LazyForEachSequence(base: self, perform: body)
    }
}
