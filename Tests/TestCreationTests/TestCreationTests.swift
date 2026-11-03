import Testing
@testable import TestCreation

@Test func example() {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    
    setenv("USE_PYTHON_FOR_AI_ANALYSIS", "true",1)
    //initializing the python envirionment that will allow us to run python
    print(PythonEnvironment.autoInitialize())
   // PythonEnvironment.inititize(pythonLib: URL(string: "/Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12")!)
    
    var question = Question(creator: UUID(), questionName: "", questionText: "", questionContent: QuestionContent{}, questionContentSizeX: 0, questionContentSizeY: 0, questionAnswer: "The cat drinks water.")
    
    question.usingNLIToCheckSemanticMeaning = true
    question.input = "The cat sips water."
    
    question.checkAnswer()
 
    print("h")
    question.checkAnswer()
    
    question.useNLIToCheckAnswers()
    
    
    #expect(question.isAnswerCorrect == true)
     
}
@Test func t() {
    print("h2")
    var question = Question(creator: UUID(), questionName: "", questionText: "", questionContent: QuestionContent{}, questionContentSizeX: 0, questionContentSizeY: 0, questionAnswer: "The cat drinks water.")
    
    question.usingNLIToCheckSemanticMeaning = true
    question.input = "The cat sips water."
    question.useNLIToCheckAnswers()
    
}


