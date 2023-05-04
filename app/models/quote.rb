class Quote < ApplicationRecord
    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # Should be executed every time a new quote is inserted into the database.
    after_create_commit -> { 
                                # instructs our app that the HTML of the created
                                # quote should be broadcasted to users subscribed
                                # to the "quotes" stream and prepended to the DOM
                                # node with the id of "quotes".

                                broadcast_prepend_to "quotes"

                                # https://www.hotrails.dev/turbo-rails/turbo-streams
                                # Under the hood, Turbo has a default value for both the partial and the locals option.
                                # partial: "quotes/quote", 
                                # locals: { quote: self }, 
                                # By default, the target option will be equal to model_name.plural, 
                                # target: "quotes" 
                            }
    after_update_commit -> { broadcast_replace_to "quotes" }
    after_destroy_commit -> { broadcast_remove_to "quotes" }                  
end
