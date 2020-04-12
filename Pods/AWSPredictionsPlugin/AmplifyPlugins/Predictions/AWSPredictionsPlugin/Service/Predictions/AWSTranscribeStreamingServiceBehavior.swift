//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSTranscribeStreaming

protocol AWSTranscribeStreamingServiceBehavior {

    typealias TranscribeServiceEventHandler = (TranscribeServiceEvent) -> Void
    typealias TranscribeServiceEvent = PredictionsEvent<SpeechToTextResult, PredictionsError>

    func transcribe(speechToText: URL, language: LanguageType?, onEvent: @escaping TranscribeServiceEventHandler)
}
