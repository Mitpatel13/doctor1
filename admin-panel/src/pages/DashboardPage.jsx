import { useEffect, useState } from 'react';
import { collection, getCountFromServer, query, where } from 'firebase/firestore';
import { db, isFirebaseConfigured } from '../firebase';

const todayStart = () => {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate());
};

export default function DashboardPage() {
  const [stats, setStats] = useState({
    totalUsers: '--',
    dailyActiveUsers: '--',
    newMatchesToday: '--',
  });
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isFirebaseConfigured || !db) {
      return;
    }

    const loadStats = async () => {
      try {
        setError('');
        const start = todayStart();

        const [usersSnapshot, activeSnapshot, matchesSnapshot] = await Promise.all([
          getCountFromServer(collection(db, 'users')),
          getCountFromServer(
            query(collection(db, 'users'), where('lastActiveAt', '>=', start)),
          ),
          getCountFromServer(
            query(collection(db, 'matches'), where('createdAt', '>=', start)),
          ),
        ]);

        setStats({
          totalUsers: usersSnapshot.data().count,
          dailyActiveUsers: activeSnapshot.data().count,
          newMatchesToday: matchesSnapshot.data().count,
        });
      } catch (loadError) {
        setError(
          'Unable to load dashboard stats. Verify Firestore collections and timestamp fields (users.lastActiveAt, matches.createdAt).',
        );
      }
    };

    loadStats();
  }, []);

  return (
    <section>
      <h2>Dashboard</h2>
      <ul>
        <li>Total users: {stats.totalUsers}</li>
        <li>Daily active users: {stats.dailyActiveUsers}</li>
        <li>New matches today: {stats.newMatchesToday}</li>
      </ul>
      {error && <p style={{ color: '#b42318' }}>{error}</p>}
    </section>
  );
}
