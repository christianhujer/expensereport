export type Writer = (text: string) => void;

export const printMessage: Writer = (text: string) => {
  process.stdout.write(text);
};
