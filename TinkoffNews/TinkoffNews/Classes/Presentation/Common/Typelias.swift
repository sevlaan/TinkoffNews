//
//  Typelias.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

typealias LoadingEvent = (_ isLoading: Bool) -> ()
typealias ErrorEvent = (_ error: ServiceError) -> ()
typealias Event = () -> ()
