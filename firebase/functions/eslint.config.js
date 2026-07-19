/* eslint-env node */
module.exports = {
  root: true,
  env: { es2022: true, node: true },
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  ignorePatterns: ['lib/', 'node_modules/'],
};
