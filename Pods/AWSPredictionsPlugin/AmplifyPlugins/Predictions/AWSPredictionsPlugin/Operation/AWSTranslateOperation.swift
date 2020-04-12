//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Amplify
import AWSPluginsCore

public class AWSTranslateOperation: AmplifyOperation<PredictionsTranslateTextRequest,
    Void, TranslateTextResult, PredictionsError>,
PredictionsTranslateTextOperation {

    let predictionsService: AWSPredictionsService

    init(_ request: PredictionsTranslateTextRequest,
         predictionsService: AWSPredictionsService,
         listener: EventListener?) {
        self.predictionsService = predictionsService
        super.init(categoryType: .predictions,
                   eventName: HubPayload.EventName.Predictions.translate,
                   request: request,
                   listener: listener)
    }

    override public func cancel() {
        super.cancel()
    }

    override public func main() {
        if isCancelled {
            finish()
            return
        }

        if let error = request.validate() {
            dispatch(event: .failed(error))
            finish()
            return
        }

        predictionsService.translateText(text: request.textToTranslate,
                                         language: request.language,
                                         targetLanguage: request.targetLanguage) { [weak self] event in
                                            self?.onServiceEvent(event: event)

        }
    }

    private func onServiceEvent(event: PredictionsEvent<TranslateTextResult, PredictionsError>) {
        switch event {
        case .completed(let result):
            dispatch(event: .completed(result))
            finish()
        case .failed(let error):
            dispatch(event: .failed(error))
            finish()

        }
    }

}
