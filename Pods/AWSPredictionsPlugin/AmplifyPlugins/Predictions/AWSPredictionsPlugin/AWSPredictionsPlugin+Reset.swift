//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Amplify
import AWSPluginsCore

extension AWSPredictionsPlugin {

    public func reset(onComplete: @escaping BasicClosure) {
        if predictionsService != nil {
            predictionsService.reset()
            predictionsService = nil
        }

        if authService != nil {
            authService.reset()
            authService = nil
        }

        if queue != nil {
            queue = nil
        }

        onComplete()
    }
}
