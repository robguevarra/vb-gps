

# **WHAT IS DONE**
- We have already developed the dashboard for all the roles, with the functionalities, using a superadmin that can switch dashboard and pretend to login as user profiles dropdown selector. 
- We have already created roles on our supabase database, and tested the redirects to specific dashboards based on user role. The redirects are working.
- We have implemented role-based authentication and authorization using Supabase Auth
- Created separate dashboard layouts and components for each role:
  - Missionary: Can view donations, submit surplus/leave requests, see reports
  - Finance Officer: Can record offline donations, view recent transactions
  - Campus Director: Shares dashboard with Missionary, additional option to approve/reject requests from missionaries
  - Lead Pastor: Has override capabilities for approvals
  - Superadmin: Full system access and reporting, has dashboard selector

- Built core database tables in Supabase:
  - profiles: Stores user profile data linked to auth.users
  - donor_donations: Records all donation transactions
  - donors: Records all donors
  - surplus_requests: Tracks surplus fund requests
  - leave_requests: Manages missionary leave requests
  - local_churches: Maintains church/location data

- Implemented key features:
  - Role-based dashboard routing and access control
  - Initial reporting capabilities for superadmin
  - Profile management and role assignment
  - Superadmin role-switching functionality for testing

- Set up development environment:
  - Next.js 13+ with App Router
  - Supabase for backend and auth
  - Tailwind CSS for styling
  - TypeScript for type safety
  - Shadcn/UI for components

- Structure of the project
    - global layout
        - sidebar
        - navbar
    - dashboard layout
    - dashboard components
        - missionary
            - DashboardCards.tsx
            - RecentDonations.tsx
            - LeaveRequestModal.tsx
            - SurplusRequestModal.tsx
            - ApprovalTab.tsx
            - RequestHistoryTab.tsx
            - ManualRemittanceWizard.tsx
            - ReportsTab.tsx
        - finance
            - DonationModal.tsx
            - RecentTransactions.tsx
        - lead pastor
            - LeadPastorDashboardClient.tsx
            - LeadPastorSelector.tsx
        - superadmin
            - SuperAdminSidebar.tsx
            - ChurchesList.tsx
            - UsersList.tsx
            - GlobalReportsTab.tsx
                - ChurchesTable.tsx
                - MissionariesTable.tsx
                - PartnersTable.tsx
                - ReportsTabs.tsx
                - TopMetricsCards.tsx
            - SettingsLayout.tsx



*Finance Dashboard:*
    Explanation
    Fetching the Finance Officer’s Profile:
    We query the profiles table for the current user's profile to obtain the local_church_id.

    Filtering Missionary Profiles:
    We then query the profiles table for users with the role "missionary" and add an additional condition .eq('local_church_id', financeProfile?.local_church_id) so that only missionaries belonging to the same local church as the finance officer are fetched.

    Passing the Filtered Data:
    The filtered list is passed as a prop to the DonationModal, which uses it to populate the "Select Missionary" dropdown.

*New Update*
- Changed the way we fetch roles. Implemented a user_roles table to store the roles of the users.
- Finance route already working. Able to login with finance role and able to go straight to finance dashboard. 


# **Currently working on**\
- All the other dashboards need editting to apply getUserRole.ts to fetch the correct roles. 

Finance dashboard recent transactions:
- should be able to see offline transactions made my finance officer. 


# **WHAT IS NEXT**
- Now we need to make sure all the dashboards are working as expected, sensitive to the role of the user, enable RLS for all the tables, and make sure the data is correct.




# **BRAIN DUMP**
- add surplus logic sa superadmin reports and to the whole data. 
- trigger surplus compute or something


- try to fix approval logic for surplus and leave request. 
- i think its trying to check who is assigned to the request, instead of just looking at the local church. 


- finance
    - recent transactions - lalabas lang dapat ng transactions ni finance mismo. 
    - record donations not working yet

- lead pastor dashboard
    - not seeing anything
 
- API 
    - Donations
        - need to create the API for donations via xendit. 
    - Profiles
        - need to create the API for profiles so elementor can load the API data of missionaries and campus directors.
    
