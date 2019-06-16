//
//  DSL.swift
//  EasyPeasy-iOS
//
//  Created by muukii on 2019/06/12.
//

import Foundation

public protocol AttributeContainerType {
  
  func make() -> [Attribute]
}

extension Attribute : AttributeContainerType {
  public func make() -> [Attribute] {
    [self]
  }
}

struct EmptyAttributeContainer: AttributeContainerType {
  func make() -> [Attribute] {
    []
  }
}

struct MultipleAttributeContainer: AttributeContainerType {
  
  let attributes: [AttributeContainerType]
  
  init(_ attributes: [AttributeContainerType]) {
    self.attributes = attributes
  }
  
  public func make() -> [Attribute] {
    attributes.flatMap { $0.make() }
  }
}

@_functionBuilder public struct EasyBuilder {
  
  public static func buildBlock() -> AttributeContainerType { EmptyAttributeContainer() }
  
  public static func buildBlock<T : AttributeContainerType>(_ attribute: T) -> T {
    attribute
  }
  
  public static func buildBlock(_ attributes: AttributeContainerType...) -> some AttributeContainerType {
    MultipleAttributeContainer(attributes)
  }
  
}

