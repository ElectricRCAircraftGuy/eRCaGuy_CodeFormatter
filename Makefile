# Makefile to call `clang-format`
# 
# Gabriel Staples
# Aug. 2025
# 
# For a more-complete Makefile example, see: 
# https://github.com/ElectricRCAircraftGuy/eRCaGuy_Linux_Windows_CMake_Sockets_MSYS2/blob/main/Makefile
# 
# References: 
# - Aided by AIs (GitHub Copilot and Grok.com)
#

# Mark all phony (command / script-like) targets as PHONY (not real files)
.PHONY: check fix

# Check if any files in src/ or tests/ would be changed by clang-format. 
# - Ignore "src/dir_to_ignore"
# See my answer: https://stackoverflow.com/a/69830768/4561887
check:
	@echo "Checking code formatting..."
	@find src tests -not \( -path "src/dir_to_ignore*" -type d -prune \) \
		\( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.hpp" \) 2>/dev/null | \
		xargs clang-format --dry-run --Werror || \
		(echo "❌ Code formatting issues found. Run 'make fix' to fix them." && exit 1)
	@echo "✅ All files are properly formatted."

# Fix code formatting by running clang-format on all source files in src/ and tests/. 
# - Ignore "src/dir_to_ignore"
# See my answer: https://stackoverflow.com/a/69830768/4561887
fix:
	@echo "Fixing code formatting..."
	@find src tests -not \( -path "src/dir_to_ignore*" -type d -prune \) \
		\( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.hpp" \) 2>/dev/null | \
		xargs clang-format -i
	@echo "✅ Code formatting fixed. Please commit any changes."
