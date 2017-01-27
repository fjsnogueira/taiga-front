###
# Copyright (C) 2014-2015 Taiga Agile LLC <taiga@taiga.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: add-members.controller.coffee
###

taiga = @.taiga


class AddMembersController
    @.$inject = [
        "tgUserService",
        "tgCurrentUserService"
    ]

    constructor: (@userService, @currentUserService) ->
        @._getContacts()

        @.contactsToInvite = Immutable.List()
        @.emailsToInvite = []
        @.displayContactList = false

    _getContacts: () ->
        currentUser = @currentUserService.getUser()
        @userService.getContacts(currentUser.get("id")).then (contacts) =>
            @.contacts = contacts

    _filterContacts: (invited) ->
        @.contacts = @.contacts.filter( (contact) =>
            contact.get('id') != invited.get('id')
        )

    inviteSuggested: (contact) ->
        @.contactsToInvite = @.contactsToInvite.push(contact)
        console.log @.contactsToInvite
        @._filterContacts(contact)
        @.displayContactList = true

    inviteEmail: (email) ->
        @.emailsToInvite = @.emailsToInvite.push(email)
        @.displayContactList = true

angular.module("taigaAdmin").controller("AddMembersCtrl", AddMembersController)
