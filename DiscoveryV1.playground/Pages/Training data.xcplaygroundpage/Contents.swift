//:## Training data

import PlaygroundSupport

// Enable support for asynchronous completion handlers
PlaygroundPage.current.needsIndefiniteExecution = true

import DiscoveryV1

let discovery = setupDiscoveryV1()
let environmentID: String! = getEnvironmentID()
let collectionID: String! = getCollectionID(environmentID: environmentID)
var queryID: String!

//:### List training data

discovery.listTrainingData(environmentID: environmentID, collectionID: collectionID) {
    response, error in

    guard let dataSet = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    print(dataSet)
}

//:### Add query to training data

let examples = [TrainingExample(documentID: "adaf50f1-2526-4fad-b670-7d6e8a42e6e6", relevance: 2),
                TrainingExample(documentID: "63919442-7d5b-4cae-ab7e-56f58b1390fe", crossReference: "my_id_field:14", relevance: 4)]
discovery.addTrainingData(environmentID: environmentID, collectionID: collectionID, naturalLanguageQuery: "who is keyser soze", filter: "text:criminology", examples: examples) {
    response, error in

    guard let trainingQuery = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    queryID = trainingQuery.queryID
    print(trainingQuery)
}
queryID = "d599eda5f43f630cb3ee174760a37bca49ef0643"

//:### Get details about a query

discovery.getTrainingData(environmentID: environmentID, collectionID: collectionID, queryID: queryID) {
    response, error in

    guard let trainingQuery = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    queryID = trainingQuery.queryID
    print(trainingQuery)
}

//:### List examples for a training data query

discovery.listTrainingExamples(environmentID: environmentID, collectionID: collectionID, queryID: queryID) {
    response, error in

    guard let examples = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    print(examples)
}

//;### Add example to training data query

var exampleID = "540411ca-f2fd-4a02-aad4-870e4a430fb1"
discovery.createTrainingExample(environmentID: environmentID, collectionID: collectionID, queryID: queryID, documentID: exampleID, crossReference: "my_id_field:12", relevance: 3) {
    response, error in

    guard let example = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    print(example)
}

//:### Change label or cross reference for example

discovery.updateTrainingExample(environmentID: environmentID, collectionID: collectionID, queryID: queryID, exampleID: exampleID, crossReference: "other_field:6") {
    response, error in

    guard let example = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    print(example)
}

//:### Get details for training data example

discovery.getTrainingExample(environmentID: environmentID, collectionID: collectionID, queryID: queryID, exampleID: exampleID) {
    response, error in

    guard let example = response?.result else {
        print(error?.localizedDescription ?? "unexpected error")
        return
    }

    print(example)
}

//:### Delete example for training data query

discovery.deleteTrainingExample(environmentID: environmentID, collectionID: collectionID, queryID: queryID, exampleID: exampleID) {
    _, error in

    if let error = error {
        print(error.localizedDescription)
        return
    }

    print("The example document reference was removed from the query.")
}

//:### Delete a training query

discovery.deleteTrainingData(environmentID: environmentID, collectionID: collectionID, queryID: queryID) {
    _, error in

    if let error = error {
        print(error.localizedDescription)
        return
    }

    print("Query and all example document references successfully removed from the training set for this collection.")
}

//:### Delete all training data

discovery.deleteAllTrainingData(environmentID: environmentID, collectionID: collectionID) {
    _, error in

    if let error = error {
        print(error.localizedDescription)
        return
    }

    print("All training data removed.")
}
