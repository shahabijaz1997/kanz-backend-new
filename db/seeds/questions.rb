# frozen_string_literal: true

# questions = [
#   {
#     step: 1,
#     index: 1,
#     required: true,
#     category: 'Investment Objective',
#     category_ar: 'هدف الاستثمار',
#     title: 'Investment Objective',
#     title_ar: 'هدف الاستثمار',
#     statement: 'What are your investment objectives for this portfolio?',
#     statement_ar: 'ما هي أهدافك الاستثمارية لهذه المحفظة؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [
#         { index: 1, statement: 'Income', statement_ar: 'دخل', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 2, statement: 'Total Return', statement_ar: 'عودة كاملة', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 3,	statement: 'Growth', statement_ar: 'نمو' ,is_range: false, lower_limit: 0, uper_limit: 0 }
#       ]
#     }
#   },
#   {
#     step: 1,
#     index: 2,
#     required: true,
#     title: 'Income Requirement',
#     title_ar: 'متطلبات الدخل',
#     category: 'Investment Objective',
#     category_ar: 'هدف الاستثمار',
#     statement: 'Do you require any income from this investment portfolio to take care of your expenses during ' \
#                'the investment horizen indicated by you above?',
#     statement_ar: 'هل تحتاج إلى أي دخل من هذه المحفظة الاستثمارية لتكفل نفقاتك خلال \
#                أفق الاستثمار الذي أشرت إليه أعلاه؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [
#         { index: 1, statement: 'Require Regular Income', statement_ar: 'تتطلب الدخل العادي', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 2, statement: 'Require some income', statement_ar: 'تتطلب بعض الدخل' ,is_range: false, lower_limit: 0, uper_limit: 0 }
#       ]
#     }
#   },
#   {
#     step: 1,
#     index: 3,
#     required: true,
#     title: 'Liquidity Needs',
#     title_ar: 'احتياجات السيولة',
#     category: 'Investment Objective',
#     category_ar: 'هدف الاستثمار',
#     statement: 'Please indicate the percentage of your portfolio that needs to be liquid ' \
#                '(i.e., Cash, Marketable securities)',
#     statement_ar: 'يرجى تحديد النسبة المئوية لمحفظتك التي يجب أن تكون سائلة '\
#                '(أي النقد ، الأوراق المالية القابلة للتسويق)',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [
#         { index: 1, statement: '0%', statement_ar: '0%', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
#         { index: 2, statement: 'up to 33%', statement_ar: 'حتى 33٪', is_range: true, lower_limit: 0, uper_limit: 33, unit: '%' },
#         { index: 3, statement: '34 to 66%', statement_ar: '34 إلى 66٪' ,is_range: true, lower_limit: 34, uper_limit: 66, unit: '%' },
#         { index: 4, statement: '67% and higher', statement_ar: '67٪ فأكثر' ,is_range: true, lower_limit: 67, uper_limit: 100, unit: '%' },
#         { index: 5, statement: '100% (Full portfolio must be liquid)', statement_ar: '100٪ (المحفظة الكاملة يجب أن تكون سائلة)' , is_range: true, lower_limit: 100,
#           uper_limit: 100, unit: '%' }
#       ]
#     }
#   },
#   {
#     step: 2,
#     index: 1,
#     required: true,
#     category: 'Establishes your investment experience and knowledge',
#     category_ar: 'يؤسس خبرتك ومعرفتك الاستثمارية',
#     title: '',
#     title_ar: '',
#     statement: 'Do you have Investment Experience and Expertise?',
#     statement_ar: 'هل لديك خبرة وخبرة في الاستثمار؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [
#         { index: 1, statement: 'Yes', statement_ar: 'نعم', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 2, statement: 'No', statement_ar: 'لا' ,is_range: false, lower_limit: 0, uper_limit: 0 }
#       ]
#     }
#   },
#   {
#     step: 2,
#     index: 2,
#     required: true,
#     category: 'Establishes your investment experience and knowledge',
#     category_ar: 'يؤسس خبرتك ومعرفتك الاستثمارية',
#     title: '',
#     title_ar: '',
#     statement: 'What is your overall Investment Experience and Expertise?',
#     statement_ar: 'ما هي خبرتك وخبراتك الاستثمارية الشاملة؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [
#         { index: 1, statement: 'None', statement_ar: 'لا أحد' , is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 2, statement: 'Some', statement_ar: 'بعض' ,is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 3, statement: 'Moderate', statement_ar: 'معتدل', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 4, statement: 'Good', statement_ar: 'جيد', is_range: false, lower_limit: 0, uper_limit: 0 },
#         { index: 5, statement: 'Extensive', statement_ar: 'شاسِع', is_range: false, lower_limit: 0, uper_limit: 0 }
#       ]
#     }
#   }, {
#     step: 3,
#     index: 1,
#     required: true,
#     category: '',
#     category_ar: '',
#     title: '',
#     title_ar: '',
#     statement: 'What are your preferences to invest in types of assests?',
#     statement_ar: 'ما هي تفضيلاتك للاستثمار في أنواع الأصول؟',
#     question_type: Question.question_types['checkbox'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [{
#         index: 1, statement: 'Startups', statement_ar: 'الشركات الناشئة', is_range: false, lower_limit: 0, uper_limit: 0
#       },
#                { index: 2, statement: 'Real Estate', statement_ar: 'العقارات', is_range: false, lower_limit: 0, uper_limit: 0 },
#                { index: 3, statement: 'Equities', statement_ar: 'الأسهم', is_range: false, lower_limit: 0, uper_limit: 0 }]
#     }
#   }, {
#     step: 4,
#     index: 1,
#     required: true,
#     category: '',
#     category_ar: '',
#     title: 'Investment Criteria',
#     title_ar: 'معايير الاستثمار',
#     statement: 'What are the investment criteria in terms of guidelines, policies, restrictions, regulatory and ' \
#                'legal constraints, or special circumstances?',
#     statement_ar: 'ما هي معايير الاستثمار من حيث المبادئ التوجيهية والسياسات والقيود والتنظيمية و \
#                القيود القانونية ، أو الظروف الخاصة؟',
#     question_type: Question.question_types['text'],
#     description: '',
#     description_ar: '',
#     options: {}
#   }, {
#     step: 5,
#     index: 1,
#     required: true,
#     category: 'Modern Portfolio Theory',
#     category_ar: 'نظرية المحفظة الحديثة',
#     title: 'Investment Horizon',
#     title_ar: 'آفاق الاستثمار',
#     statement: 'For what time do you think you can comfortably invest a substantial part of this portfolio without ' \
#                'the requirement of any withdrawals?',
#     statement_ar: 'في أي وقت تعتقد أنه يمكنك استثمار جزء كبير من هذه المحفظة بشكل مريح بدون '\
#                   'شرط أي سحوبات؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '<h3>Modern portfolio Theory</h3>
# 							<p>Modern portfolio theory (MPT) is an investment strategy based on the idea that
# 							risk-averse investors can construct portfolio to optimize or maximizing expected
# 							return for a given level of market risk, emphasizing that risk is an inherent part of higher reward.</p>
# 							<p>According to MPT, a portfolio frontier, also known as an efficient frontier, is a set of
# 							portfolios that maximizes expected returns for each level of standard deviation (risk).
# 							A typical portfolio frontier is illustrated below:</p>
# 							<p><img src="https://i.ibb.co/SPQzC8c/investment-horizon-graph.png" /></p>',
#     description_ar: '',
#     options: {
#       schema: [{
#         index: 1, statement: 'Less than 1 year', statement_ar: 'أقل من 1 سنة', is_range: true, lower_limit: 0, uper_limit: 1, unit: 'year'
#       },
#                { index: 2, statement: '1-3 years', statement_ar: '1-3 سنوات' ,is_range: true, lower_limit: 1, uper_limit: 3, unit: 'year' },
#                { index: 3, statement: '3-5 years', statement_ar: '3-5 سنوات' ,is_range: true, lower_limit: 3, uper_limit: 5, unit: 'year' },
#                { index: 4, statement: '5-10 years', statement_ar: '5-10 سنوات' ,is_range: true, lower_limit: 5, uper_limit: 10, unit: 'year' },
#                { index: 5, statement: 'More than 10 years', statement_ar: 'أكثر من 10 سنوات' ,is_range: true, lower_limit: 10, uper_limit: 0,
#                  unit: 'year' }]
#     }
#   }, {
#     step: 5,
#     index: 2,
#     required: true,
#     category: 'Modern Portfolio Theory',
#     category_ar: 'نظرية المحفظة الحديثة',
#     title: 'Expected Return',
#     title_ar: 'العائد المتوقع',
#     statement: 'What is your expected annualized return from your investment portfolio over your investment horizon?',
#     statement_ar: 'ما هو عائدك السنوي المتوقع من محفظتك الاستثمارية خلال أفق استثمارك؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [{
#         index: 1, statement: '0 - 5%', statement_ar: '0-5٪', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%'
#       },
#                { index: 2, statement: '6 to 8%', statement_ar: '6 إلى 8٪' ,is_range: true, lower_limit: 6, uper_limit: 8, unit: '%' },
#                { index: 3, statement: '8 to 10%', statement_ar: '8 إلى 10٪' ,is_range: true, lower_limit: 8, uper_limit: 10, unit: '%' },
#                { index: 4, statement: '10 - 15%', statement_ar: '10 - 15٪' ,is_range: true, lower_limit: 10, uper_limit: 15, unit: '%' },
#                { index: 5, statement: '15 - 20%', statement_ar: '15 - 20٪' ,is_range: true, lower_limit: 15, uper_limit: 20, unit: '%' }]
#     }
#   }, {
#     step: 5,
#     index: 3,
#     required: true,
#     category: 'Modern Portfolio Theory',
#     category_ar: 'نظرية المحفظة الحديثة',
#     title: 'Loss Tolerance',
#     title_ar: 'تحمل الخسارة',
#     statement: 'What is the maximum loss of the investment portfolio (within 1 year) that you can tolerate?',
#     statement_ar: 'ما هو الحد الأقصى لخسارة المحفظة الاستثمارية (خلال سنة واحدة) التي يمكنك تحملها؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [{
#         index: 1, statement: 'None', statement_ar: 'لا أحد', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%'
#       },
#                { index: 2, statement: 'Up to 5%', statement_ar: 'ما يصل الى 5٪', is_range: true, lower_limit: 0, uper_limit: 5, unit: '%' },
#                { index: 3, statement: '6 - 10%', statement_ar: '6 - 10٪', is_range: true, lower_limit: 6, uper_limit: 10, unit: '%' },
#                { index: 4, statement: '11 - 20%', statement_ar: '11 - 20٪', is_range: true, lower_limit: 11, uper_limit: 20, unit: '%' },
#                { index: 5, statement: 'Over 20%', statement_ar: 'فوق 20٪', is_range: true, lower_limit: 20, uper_limit: 0, unit: '%' }]
#     }
#   }, {
#     step: 5,
#     index: 4,
#     required: true,
#     category: 'Modern Portfolio Theory',
#     category_ar: 'نظرية المحفظة الحديثة',
#     title: 'Response to loss in portfolio',
#     title_ar: 'الاستجابة للخسارة في المحفظة',
#     statement: 'In case of a loss in your investment portfolio beyond your normal tolerance level due to market ' \
#                'fluctuations, how would you describe your most likely response?',
#     statement_ar: 'في حالة حدوث خسارة في محفظتك الاستثمارية بما يتجاوز مستوى التحمل الطبيعي الخاص بك بسبب السوق \
#                "التقلبات ، كيف تصف استجابتك الأكثر احتمالية؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: {
#       schema: [{
#         index: 1,
#         statement: 'Liquidate (sell) your investments immediately',
#         statement_ar: 'تصفية (بيع) استثماراتك على الفور',
#         is_range: false,
#         lower_limit: 0,
#         uper_limit: 0,
#         unit: ''
#       }, {
#         index: 2,
#         statement: 'Liquidate partially and wait out in the rest of the portfolio',
#         statement_ar: 'التصفية جزئيًا والانتظار في باقي المحفظة',
#         is_range: false,
#         lower_limit: 0,
#         uper_limit: 0,
#         unit: ''
#       }, {
#         index: 3,
#         statement: 'Hold on to your investments and ride out short-term volatility in pursuit of your long-term ' \
#                    'objectives',
#         statement_ar: 'احتفظ باستثماراتك وتخلص من التقلبات قصيرة المدى سعياً وراء تحقيقك على المدى الطويل '\
#                    'أهداف',
#         is_range: false,
#         lower_limit: 0,
#         uper_limit: 0,
#         unit: ''
#       }, {
#         index: 4,
#         statement: 'Add to your investments at the lower prices',
#         statement_ar: 'أضف إلى استثماراتك بأسعار أقل',
#         is_range: false,
#         lower_limit: 0,
#         uper_limit: 0,
#         unit: ''
#       }]
#     }
#   },{
#     index: 1,
#     required: true,
#     statement: 'For investments, I have:',
#     statement_ar: 'كيف يمكنني الحصول على الاعتماد؟',
#     question_type: Question.question_types['multiple_choice'],
#     description: '',
#     description_ar: '',
#     options: [
#       { index: 1, statement: 'Income', statement_ar: 'دخل', is_range: false, lower_limit: 0, uper_limit: 0 },
#       { index: 2, statement: 'Total Return', statement_ar: 'عودة كاملة', is_range: false, lower_limit: 0, uper_limit: 0 },
#       { index: 3,	statement: 'Growth', statement_ar: 'نمو' ,is_range: false, lower_limit: 0, uper_limit: 0 }
#     ]
#   }
# ]

# questions.each do |question|
#   record = Question.find_or_initialize_by(statement: question[:statement])
#   record.update(question)
#   record.save
# end

questions = [
  {
    index: 1,
    required: true,
    statement: 'For investments, I have:',
    statement_ar: 'كيف يمكنني الحصول على الاعتماد؟',
    question_type: Question.question_types['multiple_choice'],
    description: '',
    description_ar: '',
    kind: QUESTION_KIND[:individual_accredition],
    options_attributes: [
      { 
        index: 1,
        statement: 'I have less than USD 1 million',
        statement_ar: 'أقل من 1 مليون دولار',
        is_range: true,
        lower_limit: 0,
        uper_limit: 1,
        unit: 'million',
        currency: 'USD'
      },
      { 
        index: 2,
        statement: 'I have between USD 1 million and 10 million',
        statement_ar: 'بين 1-10 مليون دولار', 
        is_range: true,
        lower_limit: 1,
        uper_limit: 10,
        unit: 'million',
        currency: 'USD'
      },
      { 
        index: 3,
        statement: 'I have over USD 10 million',
        statement_ar: 'أكثر من 10 ملايين دولار',
        is_range: true,
        lower_limit: 10,
        uper_limit: 10,
        unit: 'million',
        currency: 'USD'
      }
    ]
  },
  {
    index: 1,
    required: true,
    statement: 'For investments, I have:',
    statement_ar: 'كيف يمكنني الحصول على الاعتماد؟',
    question_type: Question.question_types['multiple_choice'],
    description: '',
    description_ar: '',
    kind: QUESTION_KIND[:firm_accredition],
    options_attributes: [{ 
        index: 1,
        statement: 'Firm has over USD 100 million in investments',
        statement_ar: "الشركة لديها أكثر من 100 مليون دولار في الاستثمارات",
        is_range: true,
        lower_limit: 100,
        uper_limit: 100,
        unit: 'million',
        currency: 'USD'
      },{ 
        index: 2,
        statement: 'Firm has between USD 50 million and 100 million in investment',
        statement_ar: "الشركة لديها بين 50 مليون و100 مليون دولار في الاستثمار", 
        is_range: true,
        lower_limit: 50,
        uper_limit: 100,
        unit: 'million',
        currency: 'USD'
      },{ 
        index: 3,
        statement: 'Firm has between USD 10 million and 50 million in investment',
        statement_ar: "الشركة لديها بين 10 ملايين و50 مليون دولار في الاستثمار",
        is_range: true,
        lower_limit: 10,
        uper_limit: 50,
        unit: 'million',
        currency: 'USD'
      },{ 
        index: 4,
        statement: 'Firm has between USD 1 million and 10 million in investment',
        statement_ar: "الشركة لديها بين 1 مليون و10 ملايين دولار في الاستثمار",
        is_range: true,
        lower_limit: 1,
        uper_limit: 10,
        unit: 'million',
        currency: 'USD'
      }
    ]
  }
]

questions.each do |question|
  record = Question.find_or_initialize_by(statement: question[:statement], kind: question[:kind])
  if record.update(question)
    p 'Successfull'
  else
    p record.errors.full_messages
  end
end
