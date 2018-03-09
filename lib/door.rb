require "aasm"

class Class 

    def lock_state(lock_name)

      aasm "#{lock_name}_lock".to_sym, namespace: "#{lock_name}".to_sym do
        state :unlocked, initial: true
        state :locked

        event "lock_#{lock_name}".to_sym do
          transitions to: :locked
        end

        event "unlock_#{lock_name}".to_sym do
          transitions to: :unlocked
        end
    
      end
    
    end

end


class Door
  include AASM

  lock_state :deadbolt
  lock_state :knob

  aasm do
    state :closed, initial: true
    state :open

    event :open do
      transitions to: :open, if: [:deadbolt_unlocked?, :knob_unlocked?]
    end

    event :close do
      transitions to: :closed, if: :deadbolt_unlocked?
    end
  end

end
