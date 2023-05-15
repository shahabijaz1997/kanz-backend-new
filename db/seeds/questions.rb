	questions = [
		{
			step: 1,
			index: 1,
			required: true,
			category: 'Investment Objective',
			title: 'Investment Objective',
			statement: 'what are your investment objectives for this portfolio?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [
					{ index: 1, statement: 'Income', is_range: false, lower_limit: 0, uper_limit: 0},
					{ index: 2, statement: 'Total Return', is_range: false, lower_limit: 0, uper_limit: 0 },
				  { index: 3,	statement: 'Growth', is_range: false, lower_limit: 0, uper_limit: 0 }
				]
			}
		},
		{
			step: 1,
			index: 2,
			required: true,
			title: 'Income Requirement',
			category: 'Investment Objective',
			statement: 'Do you require any income from this investment portfolio to take care of your expenses during the investment horizen indicated by you above?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [
					{ index: 1, statement: 'Require Regular Income', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 2, statement: 'Require some income', is_range: false, lower_limit: 0, uper_limit: 0 }
				]
			}
		},
		{
			step: 1,
			index: 3,
			required: true,
			title: 'Liquidity Needs',
			category: 'Investment Objective',
			statement: 'Please indicate the percentage of your portfolio that needs to be liquid (i.e., Cash, Marketable securities)',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [
					{ index: 1, statement: '0%', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
					{ index: 2, statement: 'up to 33%', is_range: true, lower_limit: 0, uper_limit: 33, unit: '%' },
					{ index: 3, statement: '34 to 66%', is_range: true, lower_limit: 34, uper_limit: 66, unit: '%' },
					{ index: 4, statement: '67% and higher', is_range: true, lower_limit: 67, uper_limit: 100, unit: '%' },
					{ index: 5, statement: '100% (Full portfolio must be liquid)', is_range: true, lower_limit: 100, uper_limit: 100, unit: '%' }
				]
			}
		},
		{
			step: 2,
			index: 1,
			required: true,
			category: 'Establishes your investment experience and knowledge',
			title: '',
			statement: 'Do you have Investment Experience and Expertise?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [
					{ index: 1, statement: 'Yes', is_range: false, lower_limit: 0, uper_limit: 0 },
				  { index: 2, statement: 'No', is_range: false, lower_limit: 0, uper_limit: 0 }
			  ]
			}
		},
		{
			step: 2,
			index: 2,
			required: true,
			category: 'Establishes your investment experience and knowledge',
			title: '',
			statement: 'What is your overall Investment Experience and Expertise?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [
					{ index: 1, statement: 'None', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 2, statement: 'Some', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 3, statement: 'Moderate', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 4, statement: 'Good', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 5, statement: 'Extensive', is_range: false, lower_limit: 0, uper_limit: 0 }
				]
			}
		},{
			step: 3,
			index: 1,
			required: true,
			category: '',
			title: '',
			statement: 'what are your preferences to invest in types of assests?',
			question_type: Question::question_types['checkbox'],
			description: '',
			options: {
				schema: [{
					index: 1, statement: 'Startups', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 2, statement: 'Real Estate', is_range: false, lower_limit: 0, uper_limit: 0 },
					{ index: 3, statement: 'Equities', is_range: false, lower_limit: 0, uper_limit: 0 }
				]
			}
		},{
			step: 4,
			index: 1,
			required: true,
			category: '',
			title: 'Investment Criteria',
			statement: 'what are the investment criteria in terms of guidlines, policies, restrictions, regulatory and legal constraints, or special circumstances?',
			question_type: Question::question_types['text'],
			description: '',
			options: {}
		},{
			step: 5,
			index: 1,
			required: true,
			category: 'Modern Portfolio Theory',
			title: 'Investment Horizon',
			statement: 'For what time do you think you can comfortably invest a substantial part of this portfolio without the requirement of any withdrawals?',
			question_type: Question::question_types['multiple_choice'],
			description: %q(<h3>Modern portfolio Theory</h3>
							<p>Modern portfolio theory (MPT) is an investment strategy based on the idea that  
							risk-averse investors can construct portfolio to optimize or maximizing expected 
							return for a given level of market risk, emphasizing that risk is an inherent part of higher reward.</p>
							<p>According to MPT, a portfolio frontier, also known as an efficient frontier, is a set of 
							portfolios that maximizes expected returns for each level of standard deviation (risk). 
							A typical portfolio frontier is illustrated below:</p>
							<p><img src="https://i.ibb.co/SPQzC8c/investment-horizon-graph.png" /></p>),
			options: {
				schema: [{
					index: 1, statement: 'Less than 1 year', is_range: true, lower_limit: 0, uper_limit: 1, unit: 'year' },
					{ index: 2, statement: '1-3 years', is_range: true, lower_limit: 1, uper_limit: 3, unit: 'year' },
					{ index: 3, statement: '3-5 years', is_range: true, lower_limit: 3, uper_limit: 5, unit: 'year' },
					{ index: 4, statement: '5-10 years', is_range: true, lower_limit: 5, uper_limit: 10, unit: 'year' },
					{ index: 5, statement: 'More than 10 years', is_range: true, lower_limit: 10, uper_limit: 0, unit: 'year' }
				]
			}
		},{
			step: 5,
			index: 2,
			required: true,
			category: 'Modern Portfolio Theory',
			title: 'Expected Return',
			statement: 'What is your expected annualized return from your investment portfolio over your investment horizon?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1, statement: '0 - 5%', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
					{ index: 2, statement: '6 to 8%', is_range: true, lower_limit: 6, uper_limit: 8, unit: '%' },
					{ index: 3, statement: '8 to 10%', is_range: true, lower_limit: 8, uper_limit: 10, unit: '%' },
					{ index: 4, statement: '10 - 15%', is_range: true, lower_limit: 10, uper_limit: 15, unit: '%' },
					{ index: 5, statement: '15 - 20%', is_range: true, lower_limit: 15, uper_limit: 20, unit: '%' }
				]
			}
		},{
			step: 5,
			index: 3,
			required: true,
			category: 'Modern Portfolio Theory',
			title: 'Loss Tolerance',
			statement: 'What is the maximum loss of the investment portfolio (within 1 year) that you can tolerate?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1, statement: 'None', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
					{ index: 2, statement: 'Up to 5%', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
					{ index: 3, statement: '6 - 10%', is_range: true, lower_limit: 6, uper_limit: 10, unit: '%' },
					{ index: 4, statement: '11 - 20%', is_range: true, lower_limit: 11, uper_limit: 20, unit: '%' },
					{ index: 5, statement: 'Over 20%', is_range: true, lower_limit: 20, uper_limit: 0, unit: '%' }
				]
			}
		},{
			step: 5,
			index: 4,
			required: true,
			category: 'Modern Portfolio Theory',
			title: 'Response to loss in portfolio',
			statement: 'In case of a loss in your investment portfolio beyond your normal tolerance level due to market fluctuations, how would you describe your most likely response?',
			question_type: Question::question_types['multiple_choice'],
			description: '',
			options: {
				schema: [{
					index: 1, 
					statement: 'Liquidate (sell) your investments immediately', 
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: ''
				}, {
					index: 2,
					statement: 'Liquidate partially and wait out in the rest of the portfolio',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: ''
				}, {
					index: 3,
					statement: 'Hold on to your investments and ride out short-term volatility in pursuit of your long-term objectives',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: ''
				}, {
					index: 4,
					statement: 'Add to your investments at the lower prices',
					is_range: false,
					lower_limit: 0,
					uper_limit: 0,
					unit: '' 
				}]
			}
		}
	]

	questions.each do |question|
		next if Question.exists?(statement: question[:statement])
  	record = Question.new(question)
		record.save
	end
