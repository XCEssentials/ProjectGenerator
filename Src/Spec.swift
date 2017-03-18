//
//  Spec.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/17/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

typealias SpecLine = (idention: Int, line: String)
typealias RawSpec = [SpecLine]

//===

func <<< (list: inout RawSpec, element: SpecLine)
{
    list.append(element)
}

func <<< (list: inout RawSpec, elements: RawSpec)
{
    list.append(contentsOf: elements)
}

//===

enum Spec
{
    static
    func ident(_ idention: Int) -> String
    {
        return Array(repeating: "  ", count: idention).joined()
    }
    
    static
    func key(_ v: Any) -> String
    {
        return "\(v):"
    }
    
    static
    func value(_ v: Any) -> String
    {
        return " \"\(v)\""
    }
}
