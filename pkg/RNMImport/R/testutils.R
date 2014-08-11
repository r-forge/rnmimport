# $LastChangedDate: 2010-02-12 11:11:11 +0000 (Fri, 12 Feb 2010) $
# $LastChangedBy: fgochez $
# $Rev: 15437 $
# 
# Utilities for unit testing
#
# Author: fgochez
###############################################################################


# removes the method name attribute from an object.  Meant to facilitate certain importNm tests

.removeMethName <- function(x)
{
	attr(x, "methodName") <- NULL
	x
	
}
