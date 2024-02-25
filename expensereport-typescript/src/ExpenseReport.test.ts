import { Expense, ExpenseType, printHelloWorld, printReport, sumTwoValues } from './ExpenseReport'

describe(`ExpenseReport`, () => {
    it(`should keep its original behavior`, () => {
        let interceptedOutput = ""
        jest.spyOn(process.stdout, "write").mockImplementation((output: string): boolean => {
            interceptedOutput += output
            return true;
        })
        printReport([
          new Expense(ExpenseType.DINNER, 5001)
        ])
        expect(interceptedOutput).toEqual("")
    })

    it('printReport', () => {
        const originalStdoutWrite = process.stdout.write.bind(process.stdout);

        let interceptedOutput = '';

        process.stdout.write = (
          chunk: any,
          encodingOrCallback?: string | ((error?: Error | null) => void),
          callback?: (error?: Error | null) => void
        ): boolean => {
            let content = '';

            if (typeof chunk === 'string' || Buffer.isBuffer(chunk)) {
                content = chunk.toString(typeof encodingOrCallback === 'string' ? encodingOrCallback as BufferEncoding : undefined);
            }

            interceptedOutput += content;

            if (typeof encodingOrCallback === 'function') {
                encodingOrCallback();
            } else if (typeof callback === 'function') {
                callback();
            }

            return true;
        };

        const expenses: Expense[] = [
            new Expense(ExpenseType.BREAKFAST, 1),
            new Expense(ExpenseType.BREAKFAST, 1000),
            new Expense(ExpenseType.BREAKFAST, 1001),
            new Expense(ExpenseType.DINNER, 2),
            new Expense(ExpenseType.DINNER, 5000),
            new Expense(ExpenseType.DINNER, 5001),
            new Expense(ExpenseType.CAR_RENTAL, 4),
        ];
        printReport(expenses)
        const expected = 'Expenses: 2024-02-25T09:06:36.016Z\n' +
          "Breakfast\t1\t \n" +
          "Breakfast\t1000\t \n" +
          "Breakfast\t1001\tX\n" +
          "Dinner\t2\t \n" +
          "Dinner\t5000\t \n" +
          "Dinner\t5001\tX\n" +
          "Car Rental\t4\t \n" +
          "Meal Expenses: 12005\n" +
          "Total Expenses: 12009\n"

        process.stdout.write = originalStdoutWrite;

        expect(expected).toEqual(interceptedOutput)

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
