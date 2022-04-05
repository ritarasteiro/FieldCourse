for.gprofiler = function(pos,focus)
#input:
#pos - 2 column matrix: chr number, nucleotide position
#focus is the number of snp
#
#output:
#a character vector containing what is in each line of "gprofiler_query.txt"
#side effect: writes to file "gprofiler_query.txt" giving chromosome ranges:-
#chr number : lower nucleotide position : upper nucleotide position
#
#you can cut and paste this into g:GOSt query box
{
	chr = pos[,1]
	loc = pos[,2]
	locmin = pos[,2] - focus
	locmin = ifelse(locmin < 0,0,locmin)
	locmax = pos[,2] + focus # hope robust to being too long for chr??#
	char.out = paste(chr,":",locmin,":",locmax,sep="")
	write(char.out,file = "gprofiler_query.txt",ncol=1)
	return(char.out)
}