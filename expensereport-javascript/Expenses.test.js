const {printReport, type} = require("./Expenses")

class Expense {
  constructor(type, amount) {
    this.type = type;
    this.amount = amount;
  }
}

describe("Expenses Report Characterization tests", (object, method) => {
  let output = "";

  beforeEach(() => {
    output = "";
    jest.useFakeTimers().setSystemTime(new Date('2026-01-11'));
    jest.spyOn(process.stdout, "write").mockImplementation((text) => {
      output += text;
      return true;
    });
  });

  afterEach(() => {
    jest.useRealTimers()
    process.stdout.write.mockRestore();
  });


  test("it characterizes the report output master snapshot",  () => {
    const expense1 = new Expense(type.DINNER, 3000);
    const expense2 = new Expense(type.BREAKFAST, 500);
    const expense3 = new Expense(type.CAR_RENTAL, 4000);
    const expense4 = new Expense(type.DINNER, 6000);
    const expense5 = new Expense(type.BREAKFAST, 1500);
    printReport([expense1, expense2, expense3, expense4, expense5]);
    expect(output).toMatchSnapshot();
  })
})
