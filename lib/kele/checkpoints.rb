module Checkpoints
  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    values = {
      headers: {"authorization" => @auth_token},
      body: { "assignment_branch" => assignment_branch,
              "assignment_commit_link" => assignment_commit_link,
              "checkpoint_id" => checkpoint_id,
              "comment" => comment,
              "enrollment_id" => enrollment_id
      }
    }
    response = self.class.post(@base_url + "/checkpoint_submissions", values)
    puts response.body
  end
  
  def update_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id, submission_id)
    values = {
      headers: {"authorization" => @auth_token},
      body: { "assignment_branch" => assignment_branch,
              "assignment_commit_link" => assignment_commit_link,
              "checkpoint_id" => checkpoint_id,
              "comment" => comment,
              "enrollment_id" => enrollment_id
      }
    }
    response = self.class.put(@base_url + "/checkpoint_submissions/#{submission_id}", values)
    puts response.body
  end
end