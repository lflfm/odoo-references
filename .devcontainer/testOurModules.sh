#!/bin/bash

# include the helper functions
. /workspaces/.devcontainer/testHelpers.sh

cd /workspaces

echo ""
echo ""
echo "======================================="
__all_modules=$(getModules)
_modules_to_test=$(getTestModules "$__all_modules")

__module_count=$(echo $__all_modules | wc -w)
__num_modules_with_tests=$(echo $_modules_to_test | wc -w)

echo "Testing $__num_modules_with_tests out of $__module_count modules"
echo ""
echo "Running tests for modules: $_modules_to_test"
echo ""
sleep 2s

runTests "$_modules_to_test"
