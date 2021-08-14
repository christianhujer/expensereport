import { printHelloWorld, printReport, sumTwoValues, Expense, ExpenseType } from './ExpenseReport'

describe(`ExpenseReport`, () => {
    it(`should keep its original behavior`, () => {
        let interceptedOutput = ""
        jest.spyOn(process.stdout, "write").mockImplementation((output: string): boolean => {
            interceptedOutput += output
            return true;
        })
        printReport([
          new Expense("dinner", 5001)
        ])
        expect(interceptedOutput).toEqual("")
    })
})

describe(`given I have this test suite`, () => {
    it(`should always output Hello, World!`, () => {
        //given
        let actualOutputData = ""
        jest.spyOn(process.stdout, "write").mockImplementation((data: string): boolean => {
            actualOutputData += data
            return true
        })
        const expectedOutputData = "Hello, World!\n"

        // when
        printHelloWorld()

        // then
        expect(actualOutputData).toEqual(expectedOutputData)
    })

    it(`should always do the correct sum`, () => {
        // given
        const a = 2, b = 3
        const expectedValue = 5

        // when
        const actualValue = sumTwoValues(a, b)

        // then
        expect(actualValue).toEqual(expectedValue)
    })
})
