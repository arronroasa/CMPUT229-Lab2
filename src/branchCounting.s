#
# CMPUT 229 Student Submission License
# Version 1.0
#
# Copyright 2025 <student name>
#
# Redistribution is forbidden in all circumstances. Use of this
# software without explicit authorization from the author or CMPUT 229
# Teaching Staff is prohibited.
#
# This software was produced as a solution for an assignment in the course
# CMPUT 229 - Computer Organization and Architecture I at the University of
# Alberta, Canada. This solution is confidential and remains confidential
# after it is submitted for grading.
#
# Copying any part of this solution without including this copyright notice
# is illegal.
#
# If any portion of this software is included in a solution submitted for
# grading at an educational institution, the submitter will be subject to
# the sanctions for plagiarism at that institution.
#
# If this software is found in any public website or public repository, the
# person finding it is kindly requested to immediately report, including
# the URL or other repository locating information, to the following email
# address:
#
#          cmput229@ualberta.ca
#
#------------------------------------------------------------------------------
# CCID: arron
# Lecture Section: A1
# Instructor: Rob Hackman
# Lab Section: D01
# Teaching Assistant: Keya Malhotra, Dhanrajbir Singh Hira
#-----------------------------------------------------------------------------
#

.include "common.s"

.text

# ------------------------------------------------------------------------------
# branchCounting:
#   Counts forward and backward branch instructions in the program pointed to by a0
#	On exit, the number of forward branches should be in a0, and the number of backward branches
#	should be in a1
#
# Arguments:
#   a0: Pointer to the instructions array of the program.
#
# Return Values:
#   a0: Number of forward branches.
#   a1: Number of backward branches.
#
# Register Usage:
#
# ------------------------------------------------------------------------------

branchCounting:
	li t5, 0	# Initialize branch counters
	li t6, 0
	  # write your solution here
	loop:
		lw t0, 0(a0)	# Load 4 byte instruction, a0 is pointer to instruction
		li t1, -1	# Store sentinel value
		beq t0, t1, endLoop	# End if program runs into sentinel value
		
		# Extract opcode to check if instruction is a branch
		andi t2, t0, 0x7F
		li   t3, 0x63
		bne  t2, t3, next     # Skip instruction if not a branch

		srli	t2, t0, 31	# Extract sign bit by right shifting by
		  
		beqz	t2, addForwardBranch	# Increment forward branch counter if sign bit is 0
		bnez	t2, addBackwardBranch	# Increment backward branch counter is sign bit is 1
		
		j next
	next:
	 	addi a0, a0, 4	# Advance pointer
		j loop
	addForwardBranch:
	 	addi	t5, t5, 1
	 	j next
	addBackwardBranch:
	 	addi 	t6, t6, 1
	 	j next
	endLoop:
		mv a0, t5	# Load number of forward branches into a0
		mv a1, t6	# Load number of backward branches into a1
	ret

