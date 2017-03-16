//
//  Misc.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/15/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

typealias KeyValuePair = (String, Any)

//===

infix operator <<

func << (keyName: String, value: Any) -> KeyValuePair
{
    return (keyName, value)
}
