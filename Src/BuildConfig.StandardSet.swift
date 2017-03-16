//
//  BuildConfig.StandardSet.swift
//  MKHProjGen
//
//  Created by Maxim Khatskevich on 3/16/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

public
extension BuildConfiguration
{
    public
    typealias StandardSet =
    (
        all: Base,
        debug: BuildConfiguration,
        release: BuildConfiguration
    )
}
