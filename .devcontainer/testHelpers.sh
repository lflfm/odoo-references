#!/bin/bash

function runTests() {
	__modules="$1"
	for __module in $__modules
	do
		runTestsForModule $__module
		wait
	done
}


function runTestsForModule() {
	__module="$1"
	echo ""
	echo "======================================="
	echo "Module $__module"
	echo ""
  echo "Source code statistics"
  #funny thing about cloc, probably a bug, but a welcome one
  #manual says that it ignores test files and it does if we specify the module by name
  #but if we include the "./" in front of the module, it will include the test files :)
  #tested in the dev container running Odoo 15
  python /odoo/odoo-bin cloc -p ./$__module/ -v
	echo ""
  wait
	python /odoo/odoo-bin -i $__module -u $__module --dev all --test-tags /$__module --stop-after-init
	wait
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Finished testing module $__module"
	echo "---------------------------------------"
	echo ""
	wait
}


function getModules() {
	#create an array with all the modules
	__ALL_MODULES=$(find . -name __manifest__.py -exec dirname {} \; | xargs -I {} echo -n "{} ")
	# remove all occurences of ./
	__ALL_MODULES=${__ALL_MODULES//.\//}
	#return the list
	echo $__ALL_MODULES
}


function getTestModules() {
	__all_modules="$1"
	#loop through the modules
	for __MODULE in $__all_modules
	do
		# echo "Checking module $__MODULE" >&2
		__tests_found=0
		#check if the module has a test folder with test files
		if [ -d "$__MODULE/tests" ]; then
			if [ "$(ls -A $__MODULE/tests/test*.py)" ]; then
				#add the module to the list of modules to test
				__TEST_MODULES="$__TEST_MODULES$__MODULE "
				__tests_found=1
			fi
		fi
		if [ $__tests_found -eq 0 ]; then
			echo "WARNING: No tests found for module $__MODULE" >&2
		fi
	done
	#remove trailing space
	__TEST_MODULES=${__TEST_MODULES% }
	#return the list
	echo $__TEST_MODULES
}

