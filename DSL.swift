//
//  DSL.swift
//  EasyPeasy-iOS
//
//  Created by muukii on 2019/06/12.
//

import Foundation

public protocol _AttributeContainerType {
  
  func make() -> [Attribute]
}

extension Attribute : _AttributeContainerType {
  public func make() -> [Attribute] {
    [self]
  }
}

public struct AttributeContainer: _AttributeContainerType {
  
  let attributes: [_AttributeContainerType]
  
  init(_ attributes: [_AttributeContainerType]) {
    self.attributes = attributes
  }
  
  public func make() -> [Attribute] {
    attributes.flatMap { $0.make() }
  }
}

@_functionBuilder public struct EasyBuilder {
  
  public static func buildBlock() -> AttributeContainer {
    AttributeContainer([])
  }
  
  public static func buildBlock<T : _AttributeContainerType>(_ attribute: T) -> T {
    attribute
  }
  
  public static func buildBlock(_ attributes: _AttributeContainerType...) -> AttributeContainer {
    AttributeContainer(attributes)
  }
  
  public static func buildIf<T : _AttributeContainerType>(_ attribute: T?) -> AttributeContainer {
    AttributeContainer([attribute].compactMap { $0 })
  }
  
  public static func buildEither<T : _AttributeContainerType>(first: T) -> AttributeContainer {
    AttributeContainer([first])
  }
  
  public static func buildEither<T : _AttributeContainerType>(second: T) -> AttributeContainer {
    AttributeContainer([second])
  }

  
}

