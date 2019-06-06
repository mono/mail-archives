using System;
using NUnit.Framework;

namespace Deveel.Delicious {
	[TestFixture]
	public sealed class DeliciousTest {
		[SetUp]
		public void SetUp() {
			client = new DeliciousClient("yourusername", "yourpassword");
		}

		private DeliciousClient client;

		[Test]
		public void TestDeveelPost() {
			DeliciousPost post = new DeliciousPost("http://www.deveel.com", "The Deveel website.");
			post.Time = DateTime.Now;
			post.AddTag("development");
			post.AddTag("open-source");
			post.AddTag("c#");
			post.AddTag("mono");

			client.AddPost(post);
		}

		[Test]
		public void TestMinossePost() {
			DeliciousPost post = new DeliciousPost("http://minosse.deveel.com", "The project Minosse RDBMS.");
			post.Time = DateTime.Now;
			post.AddTag("development");
			post.AddTag("database");
			post.AddTag("sql");
			post.AddTag("open-source");
			post.AddTag("c#");
			post.AddTag("mono");

			client.AddPost(post);
		}

		[Test]
		public void TestMonoPost() {
			DeliciousPost post = new DeliciousPost("http://www.mono-project.com", "The project Mono: open-source port of .NET.");
			post.Time = DateTime.Now;
			post.AddTag("development");
			post.AddTag("open-source");
			post.AddTag("c#");
			post.AddTag("mono");
			post.AddTag(".net");
			post.AddTag("novell");

			client.AddPost(post);
		}

		[Test]
		public void TestReplaceMonoPost() {
			DeliciousPost post = new DeliciousPost("http://www.mono-project.com", "The project Mono: open-source port of .NET.");
			post.Time = DateTime.Now;
			post.AddTag("development");
			post.AddTag("open-source");
			post.AddTag("c#");
			post.AddTag("mono");
			post.AddTag(".net");
			post.AddTag("novell");
			post.IsShared = true;

			client.AddPost(post, true);
		}

		[Test]
		public void TestAllPosts() {
			TestDeveelPost();
			TestMinossePost();
			TestMonoPost();
		}

		[Test]
		public void TestGetAllPosts() {
			DeliciousPostCollection posts = client.GetAllPosts();
			foreach (DeliciousPost post in posts) {
				Console.WriteLine("URL:         {0}", post.Url);
				Console.WriteLine("Description: {0}", post.Description);
				Console.WriteLine("Tags:        {0}", post.TagString);
				Console.WriteLine("Shared:      {0}", post.IsShared);
				Console.WriteLine("----------------");
			}
		}

		[Test]
		public void TestSetBundle() {
			DeliciousBundle bundle = new DeliciousBundle("dev", new string[] { "mono", ".net", "minosse" } );

			client.SetBundle(bundle);
		}

		[Test]
		public void TestRemovePostBacked() {
			Console.WriteLine("Before modification: ");
			Console.WriteLine("================");
			Console.WriteLine();

			TestGetAllPosts();

			DeliciousPostCollection posts = client.GetAllPosts();
			posts.Remove("http://www.mono-project.com");

			Console.WriteLine("After modification: ");
			Console.WriteLine("================");
			Console.WriteLine();

			TestGetAllPosts();
		}
	}
}