import chalk from "chalk";

const message = `${chalk.blue(
  "Hello from inside your Nix-flake-provided"
)} ${chalk.green("Node.js")} ${chalk.blue("development environment")}`;

console.log(message);
