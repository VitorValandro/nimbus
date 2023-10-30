export class InvalidTimestampDate extends Error {
  constructor() {
    super(
      'Error trying to parse value to measure timestamp. The value is not a valid date.',
    );
    this.name = this.constructor.name;
  }
}
