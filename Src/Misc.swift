//
//  Misc.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/15/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
typealias KeyValuePair = (String, Any)

//===

infix operator <<<

public
func <<< (keyName: String, value: Any) -> KeyValuePair
{
    return (keyName, value)
}

//===

//infix operator </
//
//public
//func </ (keyName: String, value: Any) -> KeyValuePair
//{
//    return (keyName, value)
//}
