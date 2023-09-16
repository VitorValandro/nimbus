import { registerDecorator, ValidationOptions } from 'class-validator';

export function IsValidTimestamp(validationOptions?: ValidationOptions) {
  return function (object: object, propertyName: string) {
    registerDecorator({
      name: 'isValidTimestamp',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: unknown) {
          const parsedDate = new Date(value as any);
          return !isNaN(parsedDate.getTime());
        },
      },
    });
  };
}
