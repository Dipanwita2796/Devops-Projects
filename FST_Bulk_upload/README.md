# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

*This Shell Script will help us to automate the process of customer creation,document upload,checking the status and generating report.
* 0.0.1
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* For set up , following steps are needed. 
** Step 1: 
	Maintain all the pdf files and the excel sheet with all the details in the outside folder.The actual file name and the file name in the excel must be same and should have .pdf extension.
** Step 2: 
	All the mandatory metadata should be filled in the excel sheet for the successful upload of the document.If no value is present for a specific field keep the cell blank in excel for that field.
** Step 3: 
	For running the documents with multiple page numbers the page numbers should be separated by comma(,).
	For eg.(22,121,30).
** Step 4: 
	Provide the authorization bearer token in auth.json file.
** Step 5: 
	If any field is changed from mandatory to non mandatory or vice versa the change should be made in mandatorymetadata.json file for that specific field.For addition of any new fields the script needs to be updated.
	
### How do I run the script? ###
* To run this script, we need to pass one parameter in command line argument
**Param 1:
	Specify the host name for which you want to run the script.
	
	Go to the respective location where the script is present and run the following command.
	
	Command: bash masterscript.sh <param1>
	Ex.-     bash masterscript.sh dev.xlrt.ai
	
### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

