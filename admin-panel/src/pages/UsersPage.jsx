import { useEffect, useMemo, useState } from 'react';
import { collection, getDocs, limit, orderBy, query } from 'firebase/firestore';
import { db, isFirebaseConfigured } from '../firebase';

const normalizeUser = (id, data) => ({
  id,
  name: data.name || data.fullName || 'Unknown',
  phone: data.phone || data.phoneNumber || '-',
  gender: data.gender || '-',
  age: data.age || '-',
});

export default function UsersPage() {
  const [search, setSearch] = useState('');
  const [users, setUsers] = useState([]);
  const [status, setStatus] = useState('idle');
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isFirebaseConfigured || !db) {
      return;
    }

    const loadUsers = async () => {
      try {
        setStatus('loading');
        setError('');

        const usersQuery = query(collection(db, 'users'), orderBy('name'), limit(50));
        const snapshot = await getDocs(usersQuery);
        const mapped = snapshot.docs.map((doc) => normalizeUser(doc.id, doc.data()));

        setUsers(mapped);
        setStatus('success');
      } catch (loadError) {
        setStatus('error');
        setError(
          'Unable to load users list. Ensure the users collection exists and has readable fields.',
        );
      }
    };

    loadUsers();
  }, []);

  const filteredUsers = useMemo(() => {
    const text = search.trim().toLowerCase();
    if (!text) {
      return users;
    }

    return users.filter(
      (user) =>
        user.name.toLowerCase().includes(text) ||
        user.phone.toLowerCase().includes(text) ||
        user.id.toLowerCase().includes(text),
    );
  }, [search, users]);

  return (
    <section>
      <h2>Users</h2>
      <label htmlFor="user-search">Search by name / phone / id</label>
      <br />
      <input
        id="user-search"
        type="text"
        value={search}
        onChange={(event) => setSearch(event.target.value)}
        placeholder="Search users"
      />

      {status === 'loading' && <p>Loading users...</p>}
      {status === 'error' && <p style={{ color: '#b42318' }}>{error}</p>}
      {status === 'success' && filteredUsers.length === 0 && <p>No users found.</p>}

      {filteredUsers.length > 0 && (
        <table border="1" cellPadding="8" style={{ marginTop: '1rem', borderCollapse: 'collapse' }}>
          <thead>
            <tr>
              <th>Name</th>
              <th>Phone</th>
              <th>Gender</th>
              <th>Age</th>
              <th>User ID</th>
            </tr>
          </thead>
          <tbody>
            {filteredUsers.map((user) => (
              <tr key={user.id}>
                <td>{user.name}</td>
                <td>{user.phone}</td>
                <td>{user.gender}</td>
                <td>{user.age}</td>
                <td>{user.id}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </section>
  );
}
