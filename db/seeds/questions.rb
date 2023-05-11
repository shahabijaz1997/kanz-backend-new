	questions = [
		{
			index: 1,
			required: true,
			category: 'Investment Objective',
			statement: 'what are your investment objectives for this portfolio?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{ index: 1, statement: 'Income', is_range: false, lower_limit: 0, uper_limit: 0},
				{
					index: 2,
					statement: 'Total Return',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},
				{
					index: 3,
					statement: 'Growth',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				}]
			}
		},
		{
			index: 2,
			required: true,
			category: 'Income Requirement',
			statement: 'Do you require any income from this investment portfolio to take care of your expenses during the investment horizen indicated by you above?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1,
					statement: 'Require Regular Income',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 2,
					statement: 'Require some income',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				}]
			}
		},
		{
			index: 3,
			required: true,
			category: 'Liquidity Needs',
			statement: 'Please indicate the percentage of your portfolio that needs to be liquid(i.e. Cash, Marketable Securities)',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1,
					statement: '0%',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: '%'
				},{
					index: 2,
					statement: 'upto 33%',
					is_range: true,
					lower_limit: 0,
					uper_limit: 33,
					unit: '%'
				},{
					index: 3,
					statement: '34% to 66%',
					is_range: true,
					lower_limit: 34,
					uper_limit: 66,
					unit: '%'
				},{
					index: 4,
					statement: '67% and higher',
					is_range: true,
					lower_limit: 67,
					uper_limit: 100,
					unit: '%'
				},{
					index: 5,
					statement: '100% (Full portfolio must be liquid)',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: '%'
				}]
			}
		},
		{
			index: 4,
			required: true,
			category: 'Do you have Investment Experience and Expertise?',
			statement: 'Establishes your investment experience and knowledge',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1,
					statement: 'Yes',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 2,
					statement: 'No',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				}]
			}
		},
		{
			index: 5,
			required: true,
			category: 'What is your overall Investment Experience and Expertise?',
			statement: 'Establishes your investment experience and knowledge',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1,
					statement: 'None',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 2,
					statement: 'Some',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 3,
					statement: 'Moderate',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 4,
					statement: 'Good',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 5,
					statement: 'Extensive',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				}]
			}
		},{
			index: 6,
			required: true,
			category: '',
			statement: 'what are your preferences to invest in types of assests?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1,
					statement: 'Startups',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 2,
					statement: 'Real Estate',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				},{
					index: 3,
					statement: 'Equities',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0
				}]
			}
			   
		},{
			index: 7,
			required: true,
			category: '',
			statement: 'what are the investment criteria in terms of guidlines, policies, restrictions, regulatory and legal constraints, or special circumstances?',
			question_type: Question::question_types['text'],
			description: '',
			options: {}
		}
	]

	questions.each do |question|
		next if Question.exists?(statement: question[:statement])
  	record = Question.new(question)
		record.save
	end


