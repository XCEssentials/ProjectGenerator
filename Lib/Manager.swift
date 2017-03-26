//
//  Manager.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
enum Manager
{
    public
    static
    func prepareSpec(
        version: String = "1.2.1",
        for project: Project
        ) -> String
    {
        let rawSpec: RawSpec
        
        //===
        
        switch version
        {
            case "1.2.1":
                rawSpec = Spec_1_2_1.generate(for: project)
            
            default:
                rawSpec = Spec_1_2_1.generate(for: project)
        }
        
        //===
        
        return rawSpec
            .map { "\(Spec.ident($0))\($1)" }
            .joined(separator: "\n")
    }
}
