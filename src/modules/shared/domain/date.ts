export class DateDomain {
  constructor() {}

  static addHoursToDate(inputDate: Date, hoursToAdd: number): Date {
    const resultDate = new Date(inputDate);
    resultDate.setHours(resultDate.getHours() + hoursToAdd);
    return resultDate;
  }
}
