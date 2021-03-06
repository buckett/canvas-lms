#
# Copyright (C) 2017 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

class AnnouncementIndex
  class << self
    include SeleniumDependencies

    # ---------------------- Page ----------------------
    def visit(course)
      get("/courses/#{course.id}/announcements/")
      wait_for_ajaximations
    end

    def set_section_specific_announcements_flag(course, state)
      course.account.set_feature_flag! :section_specific_announcements, state
    end

    def new_announcement_url
      '/discussion_topics/new?is_announcement=true'
    end

    def individual_announcement_url(announcement)
      "/discussion_topics/#{announcement.id}"
    end

    # ---------------------- Controls ----------------------
    def filter_dropdown
      # f('.filter_dropdown')
    end

    # def filter_item(item_name)
    #   fj("option:contains(\"#{item_name}\")")
    # end

    def search_box
      # f('.search')
    end

    def lock_button
      # f('#lock_button')
    end

    def delete_button
      # f('#delete_button')
    end

    def add_announcement_button
      f('#add_announcement')
    end

    def open_external_feeds
      f('#external_feed').click
    end

    # ---------------------- Announcement ----------------------
    # def announcement_titles
    #   announcements = ff(".discussion_topic")
    #   announcements.map! { |x| f(".discussion-title", x).text }
    # end

    def announcement(title)
      fj(".ic-announcement-row:contains('#{title}')")
    end

    def announcement_title(title)
      f('h3', announcement(title))
    end

    def announcement_checkbox(title)
      # f('.check', announcement(title))
    end

    def announcement_sections(title)
      # section_elements = ff('#sections', announcement(title))
      # section_elements.map(&:text)
    end

    def announcement_unread_pill(title)
      f('.ic-unread-badge__unread-count', announcement(title))
    end

    def announcement_unread_number(title)
      announcement_unread_pill(title).text
    end

    def announcement_locked_icon(title)
      # f('.lock', announcement(title))
    end

    # ---------------------- Actions ----------------------
    def select_filter(filter_name)
      click_option(search_box, filter_name, :text)
      wait_for_ajaximations
      # if ^ doesn't work uncomment filter_item above and try this
      # filter_dropdown.click
      # filter_item(filter_name).click
    end

    def enter_search(title)
      set_value(search_box, title)
      driver.action.send_keys(:enter).perform
    end

    def check_announcement(title)
      announcement_checkbox(title).click
    end

    def toggle_lock
      lock_button.click
    end

    def click_delete
      delete_button.click
    end

    def click_on_announcement(title)
      announcement_title(title).click
    end

    def click_add_announcement
       add_announcement_button.click
    end
  end
end
